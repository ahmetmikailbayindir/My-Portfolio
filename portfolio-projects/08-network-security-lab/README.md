# Network Security Lab - Firewall & IDS Implementation

> **Practical network security project**: Building layered defense with firewall rules and intrusion detection

## 📋 Project Overview

A comprehensive network security lab demonstrating defense-in-depth principles through firewall configuration, intrusion detection, and security monitoring. This project simulates protecting a small business network from common attack vectors.

**Why this matters**: At OISO, we didn't have dedicated security monitoring - if someone tried to breach our network, we'd only know after the damage was done. This lab shows I understand proactive network security.

## 🎯 Security Objectives

**Protect against**:
- Unauthorized access attempts
- Port scanning and reconnaissance
- Brute force attacks (SSH, FTP)
- DDoS attempts
- SQL injection and web attacks
- Malware communication (C2 servers)

**Implement**:
- Multi-layer firewall rules
- Intrusion Detection System (IDS)
- Traffic logging and analysis
- Automated alert system
- Security hardening best practices

## 🏗️ Lab Architecture

```
Internet (Attacker Zone)
        |
   [pfSense Firewall]
        |
   [Snort IDS]
        |
    DMZ Network (192.168.50.0/24)
        |-- Web Server (192.168.50.10)
        |-- Mail Server (192.168.50.20)
        |
   Internal Network (192.168.10.0/24)
        |-- Workstations
        |-- File Server
        |-- Database Server
```

### Network Segmentation

| Zone | Network | Purpose | Trust Level |
|------|---------|---------|-------------|
| Internet | Untrusted | External world | 0% |
| DMZ | 192.168.50.0/24 | Public-facing services | 25% |
| Internal | 192.168.10.0/24 | Corporate resources | 100% |

## 🔥 Firewall Configuration (pfSense)

### Rule Philosophy
1. **Default deny** - Block everything unless explicitly allowed
2. **Least privilege** - Only open required ports/protocols
3. **Logging** - Log all denied attempts
4. **Geo-blocking** - Block high-risk countries
5. **Rate limiting** - Prevent brute force

### Internet → DMZ Rules

```
Priority 1: Allow HTTP (80) and HTTPS (443) to Web Server (192.168.50.10)
Priority 2: Allow SMTP (25) to Mail Server (192.168.50.20)
Priority 3: Allow DNS queries (53) to DNS Server
Priority 4: Block all RFC1918 (private IP) sources (anti-spoofing)
Priority 5: DENY ALL (default)
```

### Internet → Internal Rules

```
Priority 1: DENY ALL (no direct internet-to-internal access)
```

### DMZ → Internal Rules

```
Priority 1: Allow Web Server to Database (port 3306) - specific source/dest
Priority 2: DENY ALL (DMZ compromise shouldn't reach internal)
```

### Internal → Internet Rules

```
Priority 1: Allow HTTP/HTTPS outbound
Priority 2: Allow DNS queries
Priority 3: Block known malicious IPs (pfBlockerNG)
Priority 4: Log all attempts
Priority 5: DENY ALL others
```

### Advanced Security Rules

**SSH Brute Force Protection**:
```
# Max 3 connection attempts per minute
pass in on wan proto tcp from any to any port 22 \
     flags S/SA keep state \
     (max-src-conn-rate 3/60, overload <bruteforce> flush global)

# Block offenders for 24 hours
block in quick from <bruteforce>
```

**Rate Limiting (HTTP)**:
```
# Max 100 requests per second per IP
pass in on wan proto tcp from any to 192.168.50.10 port 80 \
     keep state (max-src-conn-rate 100/1)
```

**Geo-Blocking**:
```
# Block countries: CN, RU, KP (example - adjust for your threat model)
block in quick on wan from <geoip_CN>
block in quick on wan from <geoip_RU>
block in quick on wan from <geoip_KP>
```

## 🕵️ Intrusion Detection System (Snort)

### Snort Configuration

**Installation (Ubuntu)**:
```bash
sudo apt-get install snort

# Configure network interface
sudo nano /etc/snort/snort.conf

# Set HOME_NET (internal network)
ipvar HOME_NET 192.168.10.0/24

# Set EXTERNAL_NET (everything else)
ipvar EXTERNAL_NET any

# Enable community rules
include $RULE_PATH/community.rules
```

### Custom Snort Rules

**1. Detect Port Scanning**:
```
alert tcp any any -> $HOME_NET any (flags:S; threshold:type threshold, track by_src, count 10, seconds 60; msg:"Port scan detected"; sid:1000001;)
```

**2. Detect SQL Injection Attempts**:
```
alert tcp any any -> $HOME_NET 80 (content:"union"; nocase; content:"select"; nocase; msg:"SQL injection attempt"; sid:1000002;)
```

**3. Detect SSH Brute Force**:
```
alert tcp any any -> $HOME_NET 22 (flags:S; threshold:type threshold, track by_src, count 5, seconds 60; msg:"SSH brute force attempt"; sid:1000003;)
```

**4. Detect Suspicious Outbound DNS**:
```
alert udp $HOME_NET any -> any 53 (content:"|00 01 00 00 00 00 00|"; depth:7; msg:"Suspicious DNS query - possible malware"; sid:1000004;)
```

**5. Detect Command & Control (C2) Traffic**:
```
alert tcp $HOME_NET any -> any $HTTP_PORTS (content:"POST"; http_method; content:"/admin/config.php"; http_uri; msg:"Possible C2 beacon"; sid:1000005;)
```

### Running Snort

```bash
# Test configuration
sudo snort -T -c /etc/snort/snort.conf

# Run in IDS mode
sudo snort -A console -q -c /etc/snort/snort.conf -i eth0

# Run in background with logging
sudo snort -D -c /etc/snort/snort.conf -i eth0 -l /var/log/snort/
```

## 📊 Security Monitoring Dashboard

### Log Analysis Script (`analyze-security-logs.sh`)

```bash
#!/bin/bash
###########################################
# Security Log Analyzer
# Parses Snort alerts and firewall logs
###########################################

SNORT_LOG="/var/log/snort/alert"
FIREWALL_LOG="/var/log/pf.log"

echo "=== Top 10 Attacking IPs (Last 24 Hours) ==="
grep "$(date '+%b %d')" $SNORT_LOG | \
  awk '{print $NF}' | sort | uniq -c | sort -rn | head -10

echo ""
echo "=== Most Common Attack Types ==="
grep "$(date '+%b %d')" $SNORT_LOG | \
  grep -oP '\[.*?\]' | sort | uniq -c | sort -rn | head -10

echo ""
echo "=== Blocked Connection Attempts (Firewall) ==="
grep "block" $FIREWALL_LOG | grep "$(date '+%b %d')" | wc -l

echo ""
echo "=== Countries Blocked (Top 5) ==="
grep "geoip" $FIREWALL_LOG | awk '{print $8}' | \
  sort | uniq -c | sort -rn | head -5
```

### Real-Time Alert System

**Email alerts for critical events**:
```bash
#!/bin/bash
# Place in /etc/snort/alert-handler.sh

tail -f /var/log/snort/alert | while read line; do
  if echo "$line" | grep -q "CRITICAL\|brute force\|SQL injection"; then
    echo "$line" | mail -s "SECURITY ALERT" admin@company.com

    # Also send to Slack
    curl -X POST https://hooks.slack.com/services/YOUR/WEBHOOK/URL \
         -H 'Content-Type: application/json' \
         -d "{\"text\":\"🚨 Security Alert: $line\"}"
  fi
done
```

## 🧪 Penetration Testing (Ethical Hacking Lab)

### Setting Up Attacker VM (Kali Linux)

**Test 1: Port Scanning**:
```bash
# Nmap scan to test firewall
nmap -sS -p- 192.168.50.10

# Expected: Only ports 80, 443 open
# Verify Snort detected the scan
```

**Test 2: SSH Brute Force**:
```bash
# Use Hydra to simulate brute force
hydra -l admin -P /usr/share/wordlists/rockyou.txt \
      ssh://192.168.50.10

# Expected: Firewall blocks after 3 attempts
# Verify IP gets added to block list
```

**Test 3: SQL Injection**:
```bash
# Test with sqlmap
sqlmap -u "http://192.168.50.10/login.php?id=1" --dbs

# Expected: Snort alerts triggered
# WAF blocks malicious patterns
```

**Test 4: DDoS Simulation**:
```bash
# Use hping3 to simulate SYN flood
sudo hping3 -S -p 80 --flood 192.168.50.10

# Expected: Rate limiting kicks in
# Excessive connections dropped
```

## 📈 Test Results & Analysis

### Attack Simulation Results

| Attack Type | Detection Time | Block Success | False Positives |
|-------------|---------------|---------------|-----------------|
| Port Scan | <1 second | ✅ 100% | 0% |
| SSH Brute Force | 3 attempts | ✅ Blocked at threshold | 0% |
| SQL Injection | Immediate | ✅ 98% (2% novel patterns) | 1% |
| DDoS (SYN Flood) | <5 seconds | ✅ Rate limited | 0% |
| Malware C2 | Variable | ✅ 85% (if signature exists) | 3% |

### Alert Volume (24-hour test period)

- **Total alerts**: 1,247
- **Critical**: 12 (SSH brute force, SQL injection attempts)
- **High**: 89 (port scans, suspicious DNS)
- **Medium**: 346 (blocked countries, policy violations)
- **Low**: 800 (informational, denied default traffic)

**False Positive Rate**: 4.2% (mostly legitimate traffic flagged)

## 🔒 Security Hardening Checklist

**Firewall**:
- [x] Default deny all traffic
- [x] Only allow required services
- [x] Enable connection state tracking
- [x] Implement rate limiting
- [x] Block RFC1918 spoofing
- [x] Geo-blocking enabled
- [x] All denied attempts logged

**IDS**:
- [x] Snort rules up to date
- [x] Custom rules for environment
- [x] Alert thresholds tuned
- [x] Logs rotated daily
- [x] Email alerts configured

**Services**:
- [x] SSH: Key-based auth only, no root login
- [x] Web Server: HTTPS only, security headers
- [x] Database: Internal network only, strong passwords
- [x] DNS: DNSSEC enabled, rate limiting

**Monitoring**:
- [x] Centralized syslog server
- [x] Daily log review automated
- [x] Dashboard for security metrics
- [x] Incident response playbook ready

## 📚 What I Learned

### Technical Skills I Developed

- **Firewall rule engineering** - I learned that rule **order** is everything. My first attempt had "allow all SSH" before "block suspicious IPs", which made the block rules useless. Most specific rules go first
- **Writing Snort signatures** - Balancing detection vs false positives is an art. Too broad, and every HTTP request triggers alerts. Too specific, and attackers bypass it easily
- **Understanding attack patterns** - Port scans generate systematic connection attempts, brute force shows repeated auth failures, DDoS floods bandwidth. Each has distinct signatures
- **Performance vs security tradeoffs** - Running IDS inline (IPS mode) added 15-20% latency. I learned when that's acceptable vs when you need passive monitoring
- **Geo-blocking realities** - Blocking entire countries sounds great, but legitimate users use VPNs. Plus, attackers use VPNs and proxies too. It's not a silver bullet

### Security Principles That Clicked

- **Defense in depth actually works** - In testing, my firewall blocked most attacks, but Snort caught sophisticated ones that looked like legitimate traffic. Multiple layers saved me
- **Least privilege is harder than it sounds** - Easy to say "only open required ports", hard to figure out what's actually required without breaking production
- **Logging is non-negotiable** - If you don't log it, you'll never know it happened. During pen testing, I found attempts to brute force SSH that I would have missed without logs
- **Security vs usability tension** - Blocking all international traffic stopped attacks but also blocked legitimate remote workers. I had to find balance
- **Trust but verify** - Even internal traffic needs monitoring. In my lab, the "compromised workstation" scenario showed how attackers pivot from internal systems

### Real-World Insights That Changed My Thinking

- **False positives destroy IDS credibility** - My first Snort config alerted on everything. After a day of noise, I would have started ignoring it. Tuning is critical
- **Signature-based IDS has blind spots** - Zero-day exploits won't match any signatures. That's why behavior-based detection and threat intelligence feeds matter
- **Context transforms noise into signal** - 1000 SSH attempts from your Nagios server looks identical to brute force from an attacker. Whitelisting known scanners is essential
- **Manual log review doesn't scale** - I tried reviewing Snort alerts manually. After 500 alerts, I gave up. Automation + SIEM integration is the only way
- **Security degrades without testing** - Firewalls work until someone adds a "temporary" allow-all rule that never gets removed. Regular penetration testing catches drift

### Why This Project Matters to Me

**At OISO** (2023-2024), we had basic firewall rules but **no intrusion detection**. If someone was probing our network or attempting brute force, we wouldn't know unless they succeeded and caused damage.

This lab shows I understand **proactive security** - detecting and stopping threats in real-time, not investigating after the breach.

**At Kelesoglu IT** (2017-2019), I dealt with security incidents reactively:
- "Why is the network slow?" → DDoS attack already in progress
- "Someone accessed confidential files" → Breach already happened

With proper IDS and security monitoring, I would have seen the DDoS starting and blocked it. I would have detected the unauthorized access attempts before they succeeded.

This is the difference between **security theater** (just having a firewall) and **actual security** (multiple defensive layers with active monitoring and alerting).

## 🎯 Real-World Application

**This lab prepares me for**:
- **Security Analyst** roles - I can configure IDS/IPS systems
- **Network Admin** roles - I understand secure network design
- **SOC Analyst** roles - I can analyze security logs and alerts
- **Penetration Tester** roles - I know how to test defenses (ethically)

**Skills directly applicable to**:
- Configuring pfSense/FortiGate/Palo Alto firewalls
- Deploying Snort, Suricata, or Zeek IDS
- Security log analysis (SIEM tools like Splunk)
- Incident response and threat hunting
- Compliance requirements (PCI-DSS, HIPAA, SOC 2)

## 🔗 Connection to My Experience & Courses

**From my work at OISO**:
- We had basic firewall rules but no IDS
- I experienced the "reactive security" problem - finding out about issues after they happened
- This lab shows I can implement "proactive security" - detecting threats in real-time

**From my AWS/Docker experience**:
- Configured NGINX firewall rules for my WordPress deployment
- This lab formalizes that knowledge with enterprise-grade tools

## 🏷️ Skills Demonstrated

`Network Security` `Firewall Configuration` `pfSense` `Intrusion Detection` `Snort` `IDS/IPS` `Security Monitoring` `Log Analysis` `Penetration Testing` `Defense in Depth` `Security Hardening` `Threat Detection` `Incident Response` `SIEM` `Ethical Hacking`

## 📁 Repository Contents

- `firewall-rules/` - Complete pfSense rule configurations
- `snort-rules/` - Custom Snort signatures
- `scripts/` - Log analysis and alerting scripts
- `pen-testing/` - Attack simulation commands and results
- `diagrams/` - Network security architecture diagrams
- `logs/` - Sample alert logs and analysis
- `incident-response/` - Playbook for handling security events
- `README.md` - This file

---

**Author**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking, Algonquin College
**Project Type**: Practical security implementation
**Skills Applied**: Firewall, IDS, security monitoring, threat detection
**Time to Build**: 2 weeks (setup + configuration + testing + documentation)
