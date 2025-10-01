# [Lab Name] - Networking Lab

## 🎯 Objective

[Describe the goal of this lab - what networking concept are you demonstrating?]

## 📐 Network Topology

```
[ASCII diagram or description of network topology]

Example:
Router1 ---- Switch1 ---- PC1
                |
               PC2
```

## 📊 IP Addressing Table

| Device | Interface | IP Address | Subnet Mask | VLAN | Default Gateway |
|--------|-----------|------------|-------------|------|----------------|
| Router1 | G0/0 | 192.168.1.1 | 255.255.255.0 | - | N/A |
| Switch1 | VLAN 1 | 192.168.1.2 | 255.255.255.0 | 1 | 192.168.1.1 |
| PC1 | NIC | 192.168.1.10 | 255.255.255.0 | 1 | 192.168.1.1 |
| PC2 | NIC | 192.168.1.11 | 255.255.255.0 | 1 | 192.168.1.1 |

## 🔧 Configuration Steps

### 1. [Device Name] Configuration

**[Step description]:**
```cisco
[IOS commands]
Router(config)# interface GigabitEthernet 0/0
Router(config-if)# ip address 192.168.1.1 255.255.255.0
Router(config-if)# no shutdown
```

### 2. [Next Device] Configuration

**[Step description]:**
```cisco
[IOS commands]
```

## ✅ Verification & Testing

### Verification Commands

**On [Device]:**
```cisco
show ip interface brief
show running-config
show [specific command]
```

**Expected Output:**
```
[Paste expected output or describe what to look for]
```

### Test Connectivity

**From [Device]:**
```
ping [destination]
traceroute [destination]
```

**Expected Results:**
- [Test 1 expected result]
- [Test 2 expected result]

## 📚 Concepts Demonstrated

### 1. [Concept Name]
- **Definition**: [Brief explanation]
- **Purpose**: [Why it's used]
- **In this lab**: [How it's applied]

### 2. [Concept Name]
- **Definition**: [Brief explanation]
- **Purpose**: [Why it's used]

## 🔍 How It Works

[Explain the packet flow or process step-by-step]

1. [Step 1 of the process]
2. [Step 2 of the process]
3. [Step 3 of the process]

## 🐛 Troubleshooting Guide

| Issue | Possible Causes | Solution |
|-------|----------------|----------|
| [Problem] | [Cause] | [Fix with command] |
| [Problem] | [Cause] | [Fix with command] |

## 📊 Expected Results

✅ [Expected outcome 1]
✅ [Expected outcome 2]
✅ [Expected outcome 3]

## 🎓 What I Learned

- [Technical concept learned]
- [Cisco IOS command skills]
- [Networking principle]
- [Troubleshooting technique]
- [Best practice]

## 🏷️ Skills Demonstrated

`Cisco Networking` `Routing` `Switching` `[Protocol]` `[Technology]` `Packet Tracer` `Network Design`

## 📁 Files Included

- `README.md` - This documentation
- `config.txt` - Complete device configurations
- `topology.png` - Network diagram (add your Packet Tracer screenshot)
- `lab.pkt` - Packet Tracer file (if available)

## 🚀 Try It Yourself

1. Open Cisco Packet Tracer
2. Create the topology as shown in the diagram
3. Apply configurations from config.txt
4. Run verification commands
5. Test connectivity with ping/traceroute

---

**Author**: Ahmet Mikail Bayindir
**Course**: CST8371 - Networking Fundamentals
**Date**: October 2025
