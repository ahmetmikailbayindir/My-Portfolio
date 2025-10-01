# Networking Fundamentals Labs (CST8371)

> Hands-on networking projects demonstrating Cisco CCNA-level skills, network design, and protocol configuration.

## 📋 Overview

This repository showcases practical networking skills developed during the CST8371 Networking course at Algonquin College. Projects include routing and switching configurations, VLAN design, subnetting, network troubleshooting, and virtualization networking concepts.

## 🎯 Projects Included

### 1. VLAN Configuration & Inter-VLAN Routing
- **Description**: Multi-VLAN network with router-on-a-stick configuration
- **Skills**: VLANs, trunking, inter-VLAN routing, Layer 2/3 switching
- **Location**: [vlan-configuration/](vlan-configuration/)

### 2. Subnetting & IP Addressing
- **Description**: Enterprise network design with VLSM subnetting
- **Skills**: Subnetting, VLSM, IP addressing, network planning
- **Location**: [subnetting-design/](subnetting-design/)

### 3. Routing Protocols (RIP, OSPF, EIGRP)
- **Description**: Dynamic routing configuration and comparison
- **Skills**: RIP, OSPF, EIGRP, routing tables, convergence
- **Location**: [routing-protocols/](routing-protocols/)

### 4. NAT vs Bridged Networking (VMware)
- **Description**: Virtual networking modes and use cases
- **Skills**: VMware networking, NAT, bridged mode, virtualization
- **Location**: [vmware-networking/](vmware-networking/)

### 5. Network Troubleshooting Lab
- **Description**: Common network issues and resolution techniques
- **Skills**: Ping, traceroute, packet analysis, troubleshooting methodology
- **Location**: [troubleshooting/](troubleshooting/)

## 🛠️ Technologies & Tools Used

- **Simulation**: Cisco Packet Tracer, GNS3
- **Virtualization**: VMware Workstation
- **Hardware**: Cisco routers (simulated), Cisco switches (simulated)
- **Protocols**: TCP/IP, VLAN (802.1Q), OSPF, EIGRP, RIP, STP, DHCP, DNS
- **Tools**: Wireshark, ping, traceroute, ipconfig/ifconfig

## 🏗️ Network Topologies

Each project includes:
- Network topology diagrams (created in draw.io or Packet Tracer screenshots)
- IP addressing tables
- Configuration files (.pkt or text exports)
- Verification outputs (show commands)

## 🚀 Key Accomplishments

- ✅ Designed and implemented multi-VLAN enterprise networks
- ✅ Configured static and dynamic routing protocols
- ✅ Performed VLSM subnetting for optimal IP allocation
- ✅ Troubleshot Layer 2 and Layer 3 connectivity issues
- ✅ Implemented security with VLANs and ACLs
- ✅ Documented network configurations professionally

## 📚 What I Learned

### Networking Concepts
I finally understood the fundamentals that make networks work:
- **OSI and TCP/IP models** - Not just memorization, but understanding why each layer exists and how to troubleshoot at each level
- **Switching vs routing** - Layer 2 moves frames based on MAC addresses, Layer 3 routes packets based on IP addresses
- **Collision and broadcast domains** - Understanding these helped me design networks that don't bring themselves down with traffic
- **MAC address tables and ARP** - The magic behind how devices actually find each other on a network

### Cisco IOS Configuration
I got hands-on with real Cisco commands:
- **CLI navigation** - I can now navigate between user mode, privileged mode, and config mode without thinking
- **Interface configuration** - Assigning IPs, enabling interfaces, setting descriptions
- **Routing protocols** - I configured static routes, RIP, OSPF, and EIGRP (OSPF is my favorite - fast convergence)
- **VLAN creation** - Segmenting networks logically instead of buying more physical switches
- **802.1Q trunking** - Carrying multiple VLANs across a single link

### Network Design
I learned to design networks like an architect:
- **Hierarchical design** - Core, distribution, and access layers make networks scalable
- **Subnetting and VLSM** - Efficient IP allocation instead of wasting addresses
- **Redundancy and convergence** - Backup paths so one failure doesn't kill the network
- **Scalability** - Designing for future growth, not just today's needs

### Troubleshooting Methodology
I developed a systematic approach:
- **Layered troubleshooting** - Start at Layer 1 (cables), work up to Layer 7 (application)
- **Show commands** - `show ip interface brief`, `show vlan brief`, `show ip route` became second nature
- **Packet capture** - Using Wireshark to see exactly what's happening on the wire
- **Common mistakes** - Wrong subnet masks, missing default gateways, VLAN mismatches

### Why This Matters

At **OISO** (2023-2024), we had network connectivity issues between departments. Understanding VLANs and inter-VLAN routing helped me diagnose that the router wasn't configured properly for VLAN 20. Before this course, I wouldn't have known where to start.

At **Kelesoglu IT** (2017-2019), we ran a flat network - everything in one broadcast domain. I didn't know any better at the time. Now I understand why that's a bad idea: broadcast storms, no traffic segmentation, and security risks. VLANs would have solved all of that.

### Real-World Impact

The subnetting skills saved me countless hours. Instead of using calculators or guessing, I can now:
- Calculate subnet masks in my head for common scenarios
- Design IP addressing schemes that don't overlap
- Allocate exactly the right number of IPs per department (not wasting /24s on 10-host networks)

## 📊 Subnetting Example

**Scenario**: Design network for company with 4 departments

| Department | Hosts Required | Network Address | Subnet Mask | Usable Range |
|-----------|----------------|-----------------|-------------|--------------|
| Sales | 50 | 192.168.1.0/26 | 255.255.255.192 | .1 - .62 |
| IT | 25 | 192.168.1.64/27 | 255.255.255.224 | .65 - .94 |
| HR | 10 | 192.168.1.96/28 | 255.255.255.240 | .97 - .110 |
| Management | 5 | 192.168.1.112/29 | 255.255.255.248 | .113 - .118 |

## 🔍 Sample Configurations

### VLAN Configuration (Switch)
```cisco
Switch(config)# vlan 10
Switch(config-vlan)# name Sales
Switch(config-vlan)# exit

Switch(config)# interface FastEthernet 0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 10
```

### Inter-VLAN Routing (Router)
```cisco
Router(config)# interface GigabitEthernet 0/0.10
Router(config-subif)# encapsulation dot1Q 10
Router(config-subif)# ip address 192.168.10.1 255.255.255.0
```

### OSPF Configuration
```cisco
Router(config)# router ospf 1
Router(config-router)# network 192.168.1.0 0.0.0.255 area 0
Router(config-router)# passive-interface GigabitEthernet 0/1
```

## 🧪 Verification Commands Used

```cisco
show ip interface brief       # Interface status and IPs
show vlan brief              # VLAN assignments
show ip route                # Routing table
show running-config          # Current configuration
show interfaces trunk        # Trunk status
ping [destination]           # Connectivity test
traceroute [destination]     # Path verification
```

## 🏷️ Skills Demonstrated

`Cisco Networking` `CCNA` `VLANs` `Routing & Switching` `Subnetting` `OSPF` `Network Design` `Packet Tracer` `Troubleshooting` `IP Addressing` `Network Documentation`

## 👤 About This Project

**Created by**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking
**Institution**: Algonquin College
**Course**: CST8371 - Networking Fundamentals

### What I Built

I built comprehensive networking labs covering:
- **Multi-VLAN networks** with router-on-a-stick inter-VLAN routing
- **VLSM subnetting designs** for efficient IP allocation across departments
- **Dynamic routing** implementations using RIP, OSPF, and EIGRP
- **VMware virtual networking** comparing NAT vs bridged modes
- **Troubleshooting scenarios** practicing systematic problem-solving

These labs taught me to think like a network engineer - not just following commands, but understanding **why** networks work the way they do.

### Skills I Can Apply Immediately

After completing these labs, I can:
- Design and subnet enterprise networks from scratch
- Configure Cisco routers and switches via CLI
- Troubleshoot connectivity issues systematically (Layer 1 through Layer 7)
- Implement VLANs for network segmentation and security
- Set up dynamic routing protocols for redundancy
- Document network configurations professionally

This is CCNA-level knowledge - the industry standard for networking professionals.

## 📄 License

This project is for educational purposes as part of the CST8371 course curriculum.

---

## 🚀 How to Use These Labs

1. Download Cisco Packet Tracer or GNS3
2. Open the `.pkt` files in the respective lab folders
3. Review the README in each folder for objectives
4. Try configuring from scratch, then compare with my solution
5. Practice verification commands to confirm everything works
