# DNS & DHCP Server Lab - Network Services Administration

> **Core network services**: Implementing DNS and DHCP for automated network management

## 📋 Project Overview

A practical implementation of DNS and DHCP services on Linux, demonstrating how networks automatically assign IP addresses and resolve domain names. These are fundamental services that every network relies on.

**Why this matters**: At OISO and The Home Store, I worked with DNS configurations for migrations and CDN setup. This lab shows I understand how to BUILD and MANAGE these services from scratch, not just configure them.

## 🎯 Lab Objectives

**Implement essential network services**:
- DNS server for internal domain resolution
- DHCP server for automatic IP assignment
- High availability with failover
- Integration with Active Directory
- Security hardening
- Monitoring and troubleshooting

## 🏗️ Lab Architecture

```
Network: 192.168.100.0/24

[Primary DNS/DHCP Server] (192.168.100.10)
        |
        |--- DHCP Scope: 192.168.100.100-200
        |--- DNS Zone: company.local
        |
[Secondary DNS Server] (192.168.100.11) - Failover
        |
[Client Workstations] (DHCP assigned)
[Servers] (Static IPs, DNS registered)
```

## 🔧 DNS Server Configuration (BIND9)

### Installation (Ubuntu Server)

```bash
# Update and install BIND9
sudo apt update
sudo apt install -y bind9 bind9utils bind9-doc dnsutils

# Enable and start service
sudo systemctl enable named
sudo systemctl start named
```

### Primary DNS Configuration

**`/etc/bind/named.conf.local`**:
```bind
// Forward zone for company.local
zone "company.local" {
    type master;
    file "/etc/bind/zones/db.company.local";
    allow-transfer { 192.168.100.11; };  // Secondary DNS
    also-notify { 192.168.100.11; };
};

// Reverse zone for 192.168.100.0/24
zone "100.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.192.168.100";
    allow-transfer { 192.168.100.11; };
    also-notify { 192.168.100.11; };
};
```

**Forward Zone File** (`/etc/bind/zones/db.company.local`):
```bind
$TTL    604800
@       IN      SOA     ns1.company.local. admin.company.local. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL

; Name servers
@       IN      NS      ns1.company.local.
@       IN      NS      ns2.company.local.

; A records for name servers
ns1     IN      A       192.168.100.10
ns2     IN      A       192.168.100.11

; Mail server
@       IN      MX  10  mail.company.local.
mail    IN      A       192.168.100.20

; Web servers
www     IN      A       192.168.100.30
intranet IN     A       192.168.100.31

; File server
fileserver IN   A       192.168.100.40

; Workstations (static entries)
ws01    IN      A       192.168.100.50
ws02    IN      A       192.168.100.51

; CNAME aliases
ftp     IN      CNAME   fileserver
webmail IN      CNAME   mail
```

**Reverse Zone File** (`/etc/bind/zones/db.192.168.100`):
```bind
$TTL    604800
@       IN      SOA     ns1.company.local. admin.company.local. (
                              3
                         604800
                          86400
                        2419200
                         604800 )

; Name servers
@       IN      NS      ns1.company.local.
@       IN      NS      ns2.company.local.

; PTR records
10      IN      PTR     ns1.company.local.
11      IN      PTR     ns2.company.local.
20      IN      PTR     mail.company.local.
30      IN      PTR     www.company.local.
40      IN      PTR     fileserver.company.local.
```

### Secondary DNS Configuration

**On Secondary Server** (`/etc/bind/named.conf.local`):
```bind
zone "company.local" {
    type slave;
    file "/var/cache/bind/db.company.local";
    masters { 192.168.100.10; };
};

zone "100.168.192.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.192.168.100";
    masters { 192.168.100.10; };
};
```

## 📡 DHCP Server Configuration (ISC DHCP)

### Installation

```bash
sudo apt install -y isc-dhcp-server

# Configure network interface
sudo nano /etc/default/isc-dhcp-server
# Set: INTERFACESv4="eth0"
```

### DHCP Configuration

**`/etc/dhcp/dhcpd.conf`**:
```dhcp
# Global settings
default-lease-time 86400;  # 24 hours
max-lease-time 604800;      # 7 days
authoritative;

# Logging
log-facility local7;

# DNS settings for clients
option domain-name "company.local";
option domain-name-servers 192.168.100.10, 192.168.100.11;

# Subnet declaration
subnet 192.168.100.0 netmask 255.255.255.0 {
    range 192.168.100.100 192.168.100.200;
    option routers 192.168.100.1;
    option broadcast-address 192.168.100.255;

    # DHCP failover configuration
    pool {
        failover peer "dhcp-failover";
        range 192.168.100.100 192.168.100.200;
    }
}

# Static IP reservations (MAC address binding)
host fileserver {
    hardware ethernet 00:11:22:33:44:55;
    fixed-address 192.168.100.40;
}

host printer01 {
    hardware ethernet AA:BB:CC:DD:EE:FF;
    fixed-address 192.168.100.60;
}

# VoIP phones - separate pool with shorter lease
group {
    option domain-name-servers 192.168.100.10;
    option tftp-server-name "tftp.company.local";

    host voip-phone1 {
        hardware ethernet 11:22:33:44:55:66;
        fixed-address 192.168.100.70;
    }
}

# Failover configuration
failover peer "dhcp-failover" {
    primary;
    address 192.168.100.10;
    port 647;
    peer address 192.168.100.11;
    peer port 647;
    max-response-delay 60;
    max-unacked-updates 10;
    mclt 3600;
    split 128;
    load balance max seconds 3;
}
```

### DHCP Failover (Secondary Server)

**On Secondary DHCP Server**:
```dhcp
failover peer "dhcp-failover" {
    secondary;
    address 192.168.100.11;
    port 647;
    peer address 192.168.100.10;
    peer port 647;
    max-response-delay 60;
    max-unacked-updates 10;
    load balance max seconds 3;
}
```

## 🔒 Security Hardening

### DNS Security (DNSSEC)

**Enable DNSSEC signing**:
```bash
# Generate keys
cd /etc/bind/zones
dnssec-keygen -a RSASHA256 -b 2048 -n ZONE company.local
dnssec-keygen -f KSK -a RSASHA256 -b 4096 -n ZONE company.local

# Sign zone
dnssec-signzone -o company.local db.company.local

# Update named.conf.local to use signed zone
```

### DHCP Security

**Prevent rogue DHCP servers**:
- Enable DHCP snooping on switches
- Use authenticated DHCP (if supported)
- Monitor for duplicate DHCP offers

### Access Control

**DNS ACLs** (`/etc/bind/named.conf.options`):
```bind
acl "trusted" {
    192.168.100.0/24;
    localhost;
};

options {
    directory "/var/cache/bind";

    recursion yes;
    allow-recursion { trusted; };
    allow-query { trusted; };
    allow-transfer { none; };

    forwarders {
        1.1.1.1;  # Cloudflare
        8.8.8.8;  # Google
    };

    dnssec-validation auto;
};
```

## 📊 Monitoring & Troubleshooting

### DNS Monitoring Script

```bash
#!/bin/bash
# dns-monitor.sh - Check DNS health

DNS_SERVER="192.168.100.10"
TEST_DOMAIN="www.company.local"
LOG="/var/log/dns-monitor.log"

# Test resolution
if dig @$DNS_SERVER $TEST_DOMAIN +short > /dev/null 2>&1; then
    echo "$(date): DNS OK" >> $LOG
else
    echo "$(date): DNS FAILURE - cannot resolve $TEST_DOMAIN" >> $LOG
    # Send alert
    echo "DNS failure on $DNS_SERVER" | mail -s "DNS Alert" admin@company.com
fi

# Check BIND service
if ! systemctl is-active --quiet named; then
    echo "$(date): BIND service DOWN" >> $LOG
    systemctl restart named
fi
```

### DHCP Lease Monitoring

```bash
#!/bin/bash
# dhcp-leases.sh - Check DHCP lease usage

LEASE_FILE="/var/lib/dhcp/dhcpd.leases"
TOTAL_IPS=100  # Pool size
THRESHOLD=80   # Alert at 80% usage

ACTIVE_LEASES=$(grep -c "binding state active" $LEASE_FILE)
USAGE=$((ACTIVE_LEASES * 100 / TOTAL_IPS))

echo "DHCP Pool Usage: $ACTIVE_LEASES/$TOTAL_IPS ($USAGE%)"

if [ $USAGE -gt $THRESHOLD ]; then
    echo "WARNING: DHCP pool is $USAGE% full!" | \
        mail -s "DHCP Pool Alert" admin@company.com
fi
```

### Testing Commands

```bash
# DNS testing
dig @192.168.100.10 www.company.local
nslookup fileserver.company.local 192.168.100.10
host mail.company.local 192.168.100.10

# Check zone transfer
dig @192.168.100.10 company.local AXFR

# DHCP testing
sudo dhclient -v eth0  # Request new lease
cat /var/lib/dhcp/dhcpd.leases  # View active leases
sudo systemctl status isc-dhcp-server
```

## 🧪 Integration Testing

### Test Scenario 1: New Client Joins Network

```bash
# On client machine
sudo dhclient -r  # Release current lease
sudo dhclient -v eth0  # Request new IP

# Expected results:
# - Receives IP from 192.168.100.100-200 range
# - DNS servers: 192.168.100.10, 192.168.100.11
# - Can resolve company.local domains
```

### Test Scenario 2: DNS Failover

```bash
# Stop primary DNS
sudo systemctl stop named

# On client, test resolution
dig www.company.local

# Expected: Secondary DNS (192.168.100.11) responds
```

### Test Scenario 3: DHCP Failover

```bash
# Stop primary DHCP
sudo systemctl stop isc-dhcp-server

# New client requests IP
# Expected: Secondary DHCP server provides lease
```

## 📚 What I Learned

### Technical Skills I Developed

- **DNS zone management** - I learned the difference between forward zones (name→IP) and reverse zones (IP→name). SOA records define zone authority, TTL controls caching. Getting these wrong breaks DNS resolution
- **DHCP scopes and reservations** - Setting up DHCP pools for dynamic allocation vs static reservations for servers. Lease times matter - too short causes churn, too long wastes IPs when devices leave
- **Failover configuration** - Split-scope model between primary/secondary DHCP servers. MCLT (Maximum Client Lead Time) prevents both servers from offering the same IP. Without proper failover, DHCP server failure kills the network
- **DNSSEC implementation** - Zone signing for authenticity, key management (KSK/ZSK), understanding the chain of trust. DNSSEC prevents DNS spoofing attacks
- **Troubleshooting DNS/DHCP** - `dig` shows exactly what DNS returns, `nslookup` tests resolution, `tcpdump` captures DHCP DORA process. Essential for diagnosing network issues

### Networking Concepts That Clicked

- **DNS hierarchy** - I finally understood how queries flow: client → recursive resolver → root servers → TLD servers (.com) → authoritative servers (company.com). Each level has redundancy
- **DHCP DORA process** - Discover (broadcast), Offer (server responds), Request (client accepts), Acknowledge (server confirms). Understanding this helped me troubleshoot why devices weren't getting IPs
- **Caching behavior** - TTL determines how long DNS records are cached. Low TTL (60s) means fast updates but more queries. High TTL (86400s) reduces load but delays changes. I learned to drop TTL before migrations
- **High availability design** - Primary/secondary DNS with zone transfers. DHCP failover with split scopes. Single point of failure = network outage
- **DNS and DHCP integration** - DHCP can update DNS dynamically when it assigns IPs. This makes DHCP clients resolvable by name automatically

### Real-World Insights I Gained

- **DNS failure breaks everything** - At The Home Store, DNS misconfiguration during migration took the site down. It wasn't the webserver, it was DNS. That's when I learned: DNS is the most critical service
- **DHCP pool exhaustion** - I configured a /28 network (14 usable IPs) for testing. Ran out after 10 devices. Monitoring DHCP pool usage prevents "no IP available" emergencies
- **Static IPs for infrastructure** - Servers, printers, network gear need static IPs. If DHCP assigned them dynamic IPs, nothing would work after DHCP restart
- **Documentation prevents chaos** - Outdated DNS records pointing to old IPs waste hours of troubleshooting. I learned to document every DNS change immediately
- **DNS amplification attacks** - Leaving DNS recursion open to the internet makes you a DDoS amplifier. Restrict recursive queries to internal networks only

### Why This Project Matters to Me

**At The Home Store** (2022-2023), I managed DNS records during site migrations:
- Moving from Shopify to Magento required DNS changes
- SSL certificate validation needed proper DNS records
- I knew enough to change A records, but didn't understand **how DNS actually worked**

This lab showed me the full picture - authoritative servers, zone files, caching, TTL propagation. Now I could **build and manage** a DNS infrastructure, not just edit records in a web UI.

**At OISO** (2023-2024), DNS and DHCP were critical services, but I never saw how they were configured. When issues occurred, I relied on senior admins. This lab shows I can now:
- Configure primary/secondary DNS servers from scratch
- Set up DHCP with proper scopes and failover
- Troubleshoot resolution issues systematically
- Implement DNSSEC for security

These are **foundational network services**. Every company network needs them. Understanding how they work makes me a better network technician.

## 🎯 Real-World Application

**This lab prepares me for**:
- Managing corporate networks (any size company needs DNS/DHCP)
- ISP operations (managing DNS for customers)
- Data center operations (internal DNS/DHCP infrastructure)
- Cloud environments (AWS Route 53 concepts)

**Skills directly applicable to**:
- Windows Server DNS/DHCP (similar concepts)
- pfSense/OPNsense built-in DNS/DHCP
- Cloud DNS services (AWS Route 53, Google Cloud DNS)
- Network automation (Ansible for DNS/DHCP management)

## 🔗 Connection to My Experience & Courses

**From CST8246 (Network Services Administration)**:
- Learned DNS/DHCP theory and configuration
- This lab implements production-ready services with failover

**From my work at The Home Store**:
- Managed DNS records during Shopify/Magento migrations
- Configured SSL certificates (requires DNS understanding)
- This lab shows I can BUILD these services, not just use them

**From my work at OISO**:
- Assisted with DNS administration for improved system reliability
- This demonstrates deeper understanding of how DNS actually works

## 🏷️ Skills Demonstrated

`DNS` `DHCP` `BIND9` `ISC DHCP Server` `Network Services` `Linux Server Administration` `High Availability` `Failover Configuration` `DNSSEC` `Service Monitoring` `Troubleshooting` `Network Infrastructure`

## 📁 Repository Contents

- `bind/` - Complete BIND9 DNS configuration and zone files
- `dhcp/` - ISC DHCP server configuration files
- `scripts/` - Monitoring and maintenance scripts
- `testing/` - Test procedures and validation scripts
- `diagrams/` - Network topology and service flow diagrams
- `docs/` - Setup guide, troubleshooting runbook
- `README.md` - This file

---

**Author**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking, Algonquin College
**Course**: CST8246 - Network Services Administration
**Project Type**: Core network services implementation
**Time to Build**: 1 week (configuration + testing + failover + documentation)
