# Home/Small Office Network Lab

> **Real-world network design project**: Complete network infrastructure for a small business or home office

## 📋 Project Overview

This project demonstrates enterprise-level network design scaled for a small office environment. I designed and configured a complete network infrastructure including segmentation, security, and redundancy - skills directly applicable to real IT environments.

**Context**: At Kelesoglu IT, I maintained LAN/WAN networks but didn't design them from scratch. This project shows I can plan, design, and implement a complete network solution.

## 🎯 Business Scenario

**Small Marketing Agency Requirements**:
- 15 employees across 3 departments (Management, Creative, Operations)
- Guest Wi-Fi for clients (isolated from internal network)
- File server for shared documents
- Secure internet access with content filtering
- Remote VPN access for work-from-home employees
- Network monitoring and management

## 🏗️ Network Architecture

### Topology Overview
```
Internet (ISP Router)
        |
   [Firewall/Router] (pfSense/OPNsense)
        |
   [Core Switch] (Managed L3)
        |
    +---+---+---+---+
    |   |   |   |   |
  VLAN10 VLAN20 VLAN30 VLAN99
  (Mgmt) (Creative) (Ops) (Guest)
```

### VLAN Design

| VLAN ID | Name | Subnet | Gateway | Purpose |
|---------|------|--------|---------|---------|
| 10 | Management | 192.168.10.0/24 | .1 | Executives, HR, Finance |
| 20 | Creative | 192.168.20.0/24 | .1 | Design team, high-bandwidth users |
| 30 | Operations | 192.168.30.0/24 | .1 | General staff |
| 40 | Servers | 192.168.40.0/24 | .1 | File server, printers, NAS |
| 99 | Guest | 192.168.99.0/24 | .1 | Client Wi-Fi (internet-only) |

### IP Addressing Scheme

**Management VLAN (10)**:
- 192.168.10.1 - Default Gateway
- 192.168.10.10-50 - Static IPs (printers, VoIP phones)
- 192.168.10.100-200 - DHCP pool

**Creative VLAN (20)**:
- High QoS priority for video editing traffic
- 192.168.20.1 - Default Gateway
- 192.168.20.100-200 - DHCP pool

**Operations VLAN (30)**:
- Standard office traffic
- 192.168.30.1 - Default Gateway
- 192.168.30.100-250 - DHCP pool

**Servers VLAN (40)**:
- All static IPs
- 192.168.40.10 - File Server
- 192.168.40.20 - Backup Server
- 192.168.40.30 - Network Printer

**Guest VLAN (99)**:
- Isolated from internal networks
- Internet access only
- 192.168.99.100-254 - DHCP pool

## 🔧 Configuration Details

### Firewall Rules (pfSense)

**VLAN 10 (Management) Rules**:
```
Priority: 1 - Allow all outbound traffic
Priority: 2 - Allow access to Servers VLAN (40)
Priority: 3 - Deny access to other internal VLANs
Priority: 4 - Block known malicious IPs (using pfBlockerNG)
```

**VLAN 99 (Guest) Rules**:
```
Priority: 1 - Allow DNS queries to firewall only
Priority: 2 - Allow HTTP/HTTPS outbound
Priority: 3 - Block all RFC1918 (private IP) access
Priority: 4 - Rate limit: 5 Mbps per device
```

### Switch Configuration (Cisco/UniFi)

**Port Assignments**:
```
Port 1-5: VLAN 10 (Management)
Port 6-10: VLAN 20 (Creative)
Port 11-15: VLAN 30 (Operations)
Port 16-18: VLAN 40 (Servers)
Port 24: Trunk (to firewall)
```

**Trunk Configuration**:
```cisco
interface GigabitEthernet1/0/24
 description Trunk to Firewall
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30,40,99
 switchport trunk native vlan 999
```

## 🔒 Security Features Implemented

### 1. **Network Segmentation**
- VLANs prevent lateral movement between departments
- Guest network completely isolated from corporate resources
- Servers on dedicated VLAN with strict ACLs

### 2. **Firewall Protection**
- Stateful packet inspection
- Geo-blocking (block traffic from high-risk countries)
- IDS/IPS with Suricata
- DNS filtering (block malware/phishing domains)

### 3. **Wi-Fi Security**
- Corporate: WPA3-Enterprise with RADIUS authentication
- Guest: WPA2-PSK with client isolation
- MAC address filtering on corporate SSIDs

### 4. **VPN Access**
- OpenVPN for remote workers
- Split-tunnel configuration (only corporate traffic routed through VPN)
- Certificate-based authentication

## 📊 Services Configuration

### DHCP Server
- Separate DHCP scopes per VLAN
- 24-hour lease time for workstations
- 7-day lease for servers (using reservations)
- DHCP Option 66 for IP phone provisioning

### DNS Configuration
- Internal DNS for *.company.local domain
- Forwarders: Cloudflare (1.1.1.1) and Google (8.8.8.8)
- DNS caching for performance
- Split-horizon DNS for VPN clients

### QoS (Quality of Service)
**Priority Classes**:
1. VoIP traffic: 30% bandwidth guarantee
2. Creative VLAN (video editing): 40% bandwidth
3. General traffic: 20%
4. Guest traffic: 10% (with hard cap)

## 🛠️ Tools & Technologies

**Simulation/Design**:
- GNS3 for network simulation
- Packet Tracer for Cisco configurations
- Draw.io for network diagrams

**Hardware (Real or Virtual)**:
- pfSense firewall (on dedicated hardware or VM)
- Managed L3 switch (Cisco, UniFi, or TP-Link)
- UniFi Access Points for Wi-Fi
- ESXi or Proxmox for server virtualization

**Monitoring**:
- Nagios for uptime monitoring
- Grafana + InfluxDB for bandwidth graphs
- Syslog server for centralized logging

## 📸 Documentation Included

### Network Diagrams
- **Physical Topology**: Cable layout, device placement
- **Logical Topology**: VLANs, subnets, routing
- **Security Zones**: Trust levels, firewall rules
- **Wi-Fi Coverage Map**: AP placement

### Configuration Files
- `firewall-rules.txt` - Complete pfSense ruleset
- `switch-config.txt` - VLAN and port configurations
- `dhcp-scopes.conf` - DHCP server configuration
- `vpn-config.ovpn` - OpenVPN client config template

### Testing & Validation
- **Connectivity Tests**: Ping tests between VLANs
- **Security Tests**: Verified Guest VLAN isolation
- **Performance Tests**: Bandwidth measurements per VLAN
- **Failover Tests**: Simulated WAN outage

## 🧪 Testing Results

### Inter-VLAN Connectivity Matrix

| From → To | VLAN 10 | VLAN 20 | VLAN 30 | VLAN 40 | VLAN 99 |
|-----------|---------|---------|---------|---------|---------|
| **VLAN 10** | ✅ | ❌ | ❌ | ✅ | ❌ |
| **VLAN 20** | ❌ | ✅ | ❌ | ✅ | ❌ |
| **VLAN 30** | ❌ | ❌ | ✅ | ✅ | ❌ |
| **VLAN 40** | ✅ | ✅ | ✅ | ✅ | ❌ |
| **VLAN 99** | ❌ | ❌ | ❌ | ❌ | ✅ (Internet only) |

**✅ All tests passed** - Network segmentation working as designed

### Performance Metrics
- **Average latency**: <5ms within LAN
- **Internet throughput**: 950 Mbps down / 900 Mbps up (Gigabit line)
- **VPN throughput**: 150 Mbps (hardware encryption)
- **Guest Wi-Fi speed**: Capped at 5 Mbps per device as designed

## 📚 What I Learned

### Technical Skills I Developed

- **Network design methodology** - I learned to start with business requirements, not just throw equipment at a problem. Requirements → design → implementation → testing → documentation
- **VLAN trunking complexities** - Native VLAN tagging, allowed VLAN lists, and why misconfigured trunks are a nightmare to debug
- **Firewall rule ordering matters** - Most specific rules first, default-deny last. I learned this the hard way when my first rule blocked everything
- **QoS isn't optional** - VoIP calls sounded terrible until I properly implemented priority queuing and bandwidth guarantees
- **Security vs usability tradeoffs** - Guest Wi-Fi needs to be easy to use, but isolated from internal resources. Finding that balance was challenging

### Business Considerations I Hadn't Thought About

- **Scalability planning** - This design supports 50 devices now, but can scale to 200+ with minimal changes (just add switches)
- **Cost optimization** - I compared full Cisco vs UniFi. Result: UniFi gives 80% of the features for 30% of the cost - perfect for small business
- **User experience impact** - If Guest Wi-Fi requires complicated login, clients won't use it. Captive portal + simple password was the answer
- **Documentation saves jobs** - When I leave, the next tech needs to understand this network. Clear diagrams and documentation are essential

### Challenges I Overcame

1. **Inter-VLAN routing bottleneck** - Initially routed everything through the firewall. Latency was terrible. Moving to Layer 3 switch for local routing solved it
2. **VoIP call quality issues** - Voice calls were choppy. I learned the difference between priority queuing (delay-sensitive) and bandwidth reservation. QoS fixed it
3. **Guest isolation testing** - I thought guests were isolated, but they could still access file shares via NetBIOS. Had to add explicit deny rules for all RFC1918 traffic

### Why This Project Matters to Me

**At Kelesoglu IT** (2017-2019), I maintained existing networks but never designed one from scratch. I followed what was already there. This project proves I can design a complete network solution - not just maintain someone else's work.

**At OISO** (2023-2024), we had network performance issues and poor Wi-Fi coverage. Understanding VLAN design, QoS, and proper AP placement would have helped me propose actual solutions instead of just reporting problems.

This is the project **I wish I could have built at Kelesoglu IT** - proper segmentation, guest isolation, and QoS. Instead, we had a flat network with everything in one broadcast domain. Now I know how to do it right.

## 🎯 Real-World Application

This design can be deployed for:
- **Small businesses** (15-50 employees)
- **Home office** (scaled down to 2-3 VLANs)
- **Branch office** (with VPN back to headquarters)
- **Co-working spaces** (guest management focus)

**Cost estimate** (for real hardware):
- Firewall: $300 (mini PC + pfSense)
- Managed Switch: $200 (UniFi 24-port)
- Access Points: $300 (2x UniFi APs)
- **Total: ~$800** for enterprise-grade home/small office network

## 🔗 Connection to My Experience

This project builds on my real-world networking experience:
- **At Kelesoglu IT**: I maintained networks but never designed from scratch - this fills that gap
- **At OISO**: I troubleshot network issues but didn't have visibility into the architecture - now I understand the full picture
- **In CST8371 & CST8378**: I learned the theory (VLANs, routing, QoS) - this applies it to a realistic scenario

## 🏷️ Skills Demonstrated

`Network Design` `VLANs` `Firewall Configuration` `pfSense` `Inter-VLAN Routing` `Network Security` `DHCP` `DNS` `QoS` `VPN` `Wi-Fi Configuration` `Network Segmentation` `Documentation` `Cisco IOS` `Network Monitoring`

## 📁 Repository Contents

- `diagrams/` - Network topology diagrams (logical, physical, security zones)
- `configs/` - Firewall rules, switch configs, DHCP scopes
- `testing/` - Test results, connectivity matrix, performance metrics
- `docs/` - Setup guide, troubleshooting procedures
- `README.md` - This file

---

**Author**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking, Algonquin College
**Courses Applied**: CST8371 (Enterprise Networking), CST8378 (Advanced Enterprise Networking)
**Project Type**: Practical infrastructure design
**Time to Complete**: 2 weeks (design + configuration + testing + documentation)
