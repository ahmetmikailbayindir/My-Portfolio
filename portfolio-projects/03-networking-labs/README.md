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
- OSI and TCP/IP models
- Switching vs routing
- Collision domains and broadcast domains
- MAC address tables and ARP

### Cisco IOS Configuration
- CLI navigation and modes
- Interface configuration
- Routing protocols (static and dynamic)
- VLAN creation and assignment
- Trunking with 802.1Q

### Network Design
- Hierarchical network design
- Subnetting and VLSM
- Redundancy and convergence
- Scalability considerations

### Troubleshooting Methodology
- Layered troubleshooting approach
- Using show commands effectively
- Packet capture analysis
- Common misconfigurations

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

## 👤 Author

**Your Name**
Computer Systems Technician - Networking
Algonquin College

## 📄 License

This project is for educational purposes as part of the CST8371 course curriculum.

---

## 🚀 How to Use These Labs

1. Download Cisco Packet Tracer or GNS3
2. Open the `.pkt` files in the respective lab folders
3. Review the README in each folder for objectives
4. Try configuring from scratch, then compare with solution
5. Practice verification commands
