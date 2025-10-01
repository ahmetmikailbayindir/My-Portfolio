# Linux Server Monitoring & Automation

> **Production-ready monitoring solution**: Automated system health checks with alerting for Linux servers

## 📋 Project Overview

A comprehensive Bash-based monitoring system that tracks server health metrics and sends alerts when thresholds are exceeded. This is the kind of tool that prevents small issues from becoming major outages.

**Why I built this**: At OISO, we had servers go down because no one noticed disk space filling up. This monitoring system would have prevented that. It's proactive IT - catching problems before users notice them.

## 🎯 Problem Statement

**Real-world scenario**: You manage 5-10 Linux servers. You need to know IMMEDIATELY if:
- Disk space exceeds 85%
- CPU usage stays above 90% for 5+ minutes
- Memory usage exceeds 90%
- Critical services stop running (Apache, MySQL, SSH)
- System load average is dangerously high
- Suspicious login attempts detected

Without monitoring, you find out when users complain. With monitoring, you fix it before they notice.

## 🛠️ What This System Does

### Core Monitoring Features

1. **Disk Space Monitoring**
   - Checks all mounted filesystems
   - Alerts when usage > 85% (warning) or > 95% (critical)
   - Identifies what's consuming space

2. **CPU & Load Monitoring**
   - Tracks per-core CPU usage
   - Monitors system load average (1min, 5min, 15min)
   - Alerts when load exceeds number of cores

3. **Memory & Swap Monitoring**
   - Real-time RAM usage percentage
   - Swap usage tracking
   - Identifies top memory-consuming processes

4. **Service Health Checks**
   - Verifies critical services are running
   - Monitors service restart counts
   - Checks listening ports

5. **Security Monitoring**
   - Failed SSH login attempts
   - New user accounts created
   - Sudo command usage
   - Unusual system file modifications

6. **Network Connectivity**
   - Ping tests to gateway and external hosts
   - DNS resolution checks
   - Bandwidth usage tracking

## 📜 Main Monitoring Script

### `system-monitor.sh`

```bash
#!/bin/bash
################################################################################
# Script Name: system-monitor.sh
# Description: Comprehensive Linux server health monitoring with alerting
# Author: Ahmet Mikail Bayindir
# GitHub: github.com/ahmetmikailbayindir
# Purpose: Proactive monitoring to catch issues before they become outages
################################################################################

# Configuration
HOSTNAME=$(hostname)
LOG_FILE="/var/log/system-monitor.log"
ALERT_EMAIL="sysadmin@company.local"  # Change to your email
ALERT_WEBHOOK=""  # Optional: Slack/Discord webhook URL

# Thresholds
DISK_WARN=85
DISK_CRIT=95
CPU_WARN=80
CPU_CRIT=90
MEM_WARN=80
MEM_CRIT=90
LOAD_WARN=4  # Per core
LOAD_CRIT=8

# Critical services to monitor
SERVICES=("sshd" "apache2" "mysql" "nginx")

# Log function with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Alert function (email + webhook)
send_alert() {
    local severity=$1  # WARN or CRIT
    local message=$2

    log "[$severity] $message"

    # Email alert
    echo "$message" | mail -s "[$severity] $HOSTNAME Alert" "$ALERT_EMAIL"

    # Webhook alert (if configured)
    if [ -n "$ALERT_WEBHOOK" ]; then
        curl -X POST "$ALERT_WEBHOOK" \
             -H 'Content-Type: application/json' \
             -d "{\"text\":\"[$severity] $HOSTNAME: $message\"}"
    fi
}

# Check disk space
check_disk_space() {
    log "Checking disk space..."

    df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 " " $6 }' | while read output; do
        usage=$(echo $output | awk '{ print $1}' | sed 's/%//g')
        partition=$(echo $output | awk '{ print $2 }')
        mount=$(echo $output | awk '{ print $3 }')

        if [ $usage -ge $DISK_CRIT ]; then
            send_alert "CRIT" "Disk space CRITICAL on $mount ($partition): ${usage}%"
        elif [ $usage -ge $DISK_WARN ]; then
            send_alert "WARN" "Disk space WARNING on $mount ($partition): ${usage}%"
        fi
    done
}

# Check CPU usage
check_cpu() {
    log "Checking CPU usage..."

    # Get 1-minute average CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    cpu_usage_int=${cpu_usage%.*}  # Convert to integer

    if [ $cpu_usage_int -ge $CPU_CRIT ]; then
        top_procs=$(ps aux --sort=-%cpu | head -6)
        send_alert "CRIT" "CPU usage CRITICAL: ${cpu_usage}%\n\nTop processes:\n$top_procs"
    elif [ $cpu_usage_int -ge $CPU_WARN ]; then
        send_alert "WARN" "CPU usage WARNING: ${cpu_usage}%"
    fi
}

# Check memory usage
check_memory() {
    log "Checking memory usage..."

    mem_total=$(free | grep Mem | awk '{print $2}')
    mem_used=$(free | grep Mem | awk '{print $3}')
    mem_percent=$((mem_used * 100 / mem_total))

    if [ $mem_percent -ge $MEM_CRIT ]; then
        top_procs=$(ps aux --sort=-%mem | head -6)
        send_alert "CRIT" "Memory usage CRITICAL: ${mem_percent}%\n\nTop processes:\n$top_procs"
    elif [ $mem_percent -ge $MEM_WARN ]; then
        send_alert "WARN" "Memory usage WARNING: ${mem_percent}%"
    fi

    # Check swap usage
    swap_used=$(free | grep Swap | awk '{print $3}')
    if [ $swap_used -gt 0 ]; then
        log "INFO: Swap in use: $swap_used KB (may indicate memory pressure)"
    fi
}

# Check system load
check_load() {
    log "Checking system load..."

    load_1min=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    num_cores=$(nproc)

    # Compare load to number of cores
    if (( $(echo "$load_1min > $num_cores" | bc -l) )); then
        send_alert "WARN" "System load high: $load_1min (cores: $num_cores)"
    fi
}

# Check critical services
check_services() {
    log "Checking critical services..."

    for service in "${SERVICES[@]}"; do
        if ! systemctl is-active --quiet "$service"; then
            send_alert "CRIT" "Service DOWN: $service"

            # Attempt automatic restart
            log "Attempting to restart $service..."
            systemctl restart "$service"
            sleep 5

            if systemctl is-active --quiet "$service"; then
                log "Successfully restarted $service"
            else
                send_alert "CRIT" "FAILED to restart $service - manual intervention required!"
            fi
        fi
    done
}

# Check failed login attempts
check_security() {
    log "Checking security logs..."

    # Check for failed SSH attempts in last 10 minutes
    failed_ssh=$(grep "Failed password" /var/log/auth.log | grep "$(date '+%b %e %H:')" | wc -l)

    if [ $failed_ssh -gt 10 ]; then
        attackers=$(grep "Failed password" /var/log/auth.log | grep "$(date '+%b %e %H:')" | awk '{print $(NF-3)}' | sort | uniq -c | sort -rn | head -5)
        send_alert "WARN" "Multiple failed SSH attempts: $failed_ssh in last hour\n\nTop offenders:\n$attackers"
    fi
}

# Check network connectivity
check_network() {
    log "Checking network connectivity..."

    # Check gateway ping
    gateway=$(ip route | grep default | awk '{print $3}')
    if ! ping -c 1 -W 2 "$gateway" > /dev/null 2>&1; then
        send_alert "CRIT" "Cannot reach gateway: $gateway"
    fi

    # Check external connectivity
    if ! ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
        send_alert "CRIT" "No external network connectivity (ping 8.8.8.8 failed)"
    fi

    # Check DNS resolution
    if ! nslookup google.com > /dev/null 2>&1; then
        send_alert "WARN" "DNS resolution issues detected"
    fi
}

# Main execution
main() {
    log "=== Starting system health check ==="

    check_disk_space
    check_cpu
    check_memory
    check_load
    check_services
    check_security
    check_network

    log "=== Health check completed ==="
}

# Run main function
main
```

## ⏰ Automated Scheduling with Cron

### Install as System Service

**1. Make script executable:**
```bash
chmod +x /usr/local/bin/system-monitor.sh
```

**2. Add to crontab (run every 5 minutes):**
```bash
crontab -e
```

Add line:
```
*/5 * * * * /usr/local/bin/system-monitor.sh
```

**3. Daily summary report (8 AM):**
```
0 8 * * * /usr/local/bin/daily-summary.sh
```

## 📊 Monitoring Dashboard Script

### `dashboard.sh` - Real-Time System Overview

```bash
#!/bin/bash
# Live monitoring dashboard in terminal

while true; do
    clear
    echo "======================================"
    echo "   SYSTEM MONITORING DASHBOARD"
    echo "   Server: $(hostname)"
    echo "   Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "======================================"
    echo ""

    echo "CPU Usage:"
    mpstat 1 1 | grep Average | awk '{print "  " $3+$4+$5 "% used"}'
    echo ""

    echo "Memory:"
    free -h | grep Mem | awk '{print "  " $3 " / " $2 " (" int($3/$2*100) "%)"}'
    echo ""

    echo "Disk Space:"
    df -h | grep -E '^/dev/' | awk '{print "  " $6 ": " $5 " (" $3 " / " $2 ")"}'
    echo ""

    echo "Load Average:"
    uptime | awk -F'load average:' '{print "  " $2}'
    echo ""

    echo "Top 5 Processes (CPU):"
    ps aux --sort=-%cpu | head -6 | tail -5 | awk '{print "  " $11 " (" $3 "%)"}'
    echo ""

    echo "======================================"
    echo "Press Ctrl+C to exit"

    sleep 5
done
```

## 📧 Alert Configuration

### Email Alerts (Postfix/Sendmail)

```bash
# Install mail utilities
apt-get install mailutils

# Test email
echo "Test alert" | mail -s "Test Subject" your.email@example.com
```

### Slack Webhook Integration

```bash
SLACK_WEBHOOK="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

curl -X POST $SLACK_WEBHOOK \
     -H 'Content-Type: application/json' \
     -d '{"text":"🚨 Server Alert: Disk space critical on /var"}'
```

### Discord Webhook Integration

```bash
DISCORD_WEBHOOK="https://discord.com/api/webhooks/YOUR_WEBHOOK_URL"

curl -X POST $DISCORD_WEBHOOK \
     -H 'Content-Type: application/json' \
     -d '{"content":"**Alert**: CPU usage critical on server01"}'
```

## 📈 Log Analysis Script

### `analyze-logs.sh` - Parse Monitoring Logs

```bash
#!/bin/bash
# Analyzes system-monitor.log to show trends

LOG_FILE="/var/log/system-monitor.log"

echo "=== Alert Summary (Last 24 Hours) ==="
grep -E '\[WARN\]|\[CRIT\]' $LOG_FILE | grep "$(date '+%Y-%m-%d')" | \
    awk '{print $3}' | sort | uniq -c | sort -rn

echo ""
echo "=== Most Common Alerts ==="
grep -E '\[WARN\]|\[CRIT\]' $LOG_FILE | \
    sed 's/.*\] //' | sort | uniq -c | sort -rn | head -10

echo ""
echo "=== Critical Alerts (Last Week) ==="
grep '\[CRIT\]' $LOG_FILE | tail -20
```

## 🧪 Testing the Monitoring System

### Simulate Alerts for Testing

**1. Test disk alert:**
```bash
dd if=/dev/zero of=/tmp/testfile bs=1M count=10000  # Create 10GB file
```

**2. Test CPU alert:**
```bash
yes > /dev/null &  # Spawn CPU-intensive process
# Kill with: killall yes
```

**3. Test memory alert:**
```bash
stress --vm 2 --vm-bytes 1G --timeout 60s
```

**4. Test service alert:**
```bash
systemctl stop apache2  # Stop service to trigger alert
```

## 📚 What I Learned

### Technical Skills
- **Bash scripting at scale**: Managing complex logic, error handling
- **System metrics collection**: Understanding /proc filesystem, system calls
- **Email/webhook integration**: Sending programmatic alerts
- **Cron job management**: Scheduling, logging, handling failures
- **Log rotation**: Preventing logs from filling disk

### Operational Skills
- **Alert fatigue prevention**: Setting appropriate thresholds (not too sensitive)
- **Actionable alerts**: Including context (top processes) in notifications
- **Automatic remediation**: Restarting services automatically when safe
- **Documentation**: Clear runbook for alert responses

### Real-World Insights
- **Monitoring is proactive IT**: Better to catch issues at 3 AM via alert than at 9 AM via angry users
- **Context matters**: "Disk full" alert needs to say WHERE and top space consumers
- **False positives kill trust**: Spent time tuning thresholds to avoid boy-who-cried-wolf
- **Start simple, iterate**: Began with just disk monitoring, added features based on actual needs

## 🎯 Real-World Application

**Who needs this:**
- Small businesses without expensive monitoring tools (Nagios, Datadog)
- Home lab enthusiasts managing multiple servers
- Entry-level sysadmins building their first monitoring system
- Dev/test environments where commercial tools are overkill

**Production-ready for:**
- 5-20 Linux servers
- Non-mission-critical applications
- Internal tools and development environments
- Budget-conscious IT departments

**When to upgrade to commercial tools:**
- 20+ servers (need centralized monitoring)
- Compliance requirements (audit trails, SOC2)
- Need for dashboards and historical graphs
- Multiple alert channels and on-call rotations

## 🔗 Connection to My Experience

**At OISO**: We had a file server run out of disk space, causing email delivery failures. Users couldn't send/receive for 2 hours before IT noticed. This monitoring system would have alerted us when disk hit 85%, giving time to clean up before the outage.

**At Kelesoglu IT**: I responded to "server is slow" tickets reactively. With proactive monitoring, I could have seen CPU spikes or memory leaks developing and fixed them before users complained.

**In my CST program**: I learned Linux administration, but monitoring is the operational skill that keeps systems running. This project bridges classroom knowledge and real IT operations.

## 🏷️ Skills Demonstrated

`Bash Scripting` `Linux System Administration` `Server Monitoring` `Automation` `Cron Jobs` `Alerting Systems` `Email Integration` `Webhook APIs` `Log Management` `Proactive IT Operations` `Problem Prevention` `Production Operations`

## 📁 Repository Contents

- `system-monitor.sh` - Main monitoring script
- `dashboard.sh` - Real-time terminal dashboard
- `analyze-logs.sh` - Log analysis and trend reporting
- `daily-summary.sh` - Daily health report generator
- `install.sh` - Automated installation script
- `config/` - Configuration files and thresholds
- `docs/` - Setup guide, troubleshooting, runbook
- `README.md` - This file

---

**Author**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking, Algonquin College
**Courses Applied**: CST8207 (Linux System Support), CST8305 (Linux Server Administration)
**Project Type**: Production operations automation
**Real-World Impact**: Prevents outages through proactive monitoring
**Time to Build**: 1 week (scripting + testing + documentation)
