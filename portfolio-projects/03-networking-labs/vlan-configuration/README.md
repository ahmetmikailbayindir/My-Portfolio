# VLAN Configuration & Inter-VLAN Routing Lab

## 🎯 Objective

Configure VLANs on a Cisco switch and implement inter-VLAN routing using the **router-on-a-stick** method to allow communication between different VLANs.

## 📐 Network Topology

```
                    Router0 (GigabitEthernet 0/0)
                           |
                           | Trunk (802.1Q)
                           |
                        Switch0
                           |
        +------------------+------------------+
        |                  |                  |
    VLAN 10            VLAN 10           VLAN 20         VLAN 20
    (Sales)            (Sales)            (IT)            (IT)
       |                  |                  |               |
      PC1                PC2                PC3             PC4
```

## 📊 IP Addressing Table

| Device | Interface | IP Address | Subnet Mask | VLAN | Default Gateway |
|--------|-----------|------------|-------------|------|----------------|
| Router0 | G0/0.10 | 192.168.10.1 | 255.255.255.0 | 10 | N/A |
| Router0 | G0/0.20 | 192.168.20.1 | 255.255.255.0 | 20 | N/A |
| PC1 | NIC | 192.168.10.10 | 255.255.255.0 | 10 | 192.168.10.1 |
| PC2 | NIC | 192.168.10.11 | 255.255.255.0 | 10 | 192.168.10.1 |
| PC3 | NIC | 192.168.20.10 | 255.255.255.0 | 20 | 192.168.20.1 |
| PC4 | NIC | 192.168.20.11 | 255.255.255.0 | 20 | 192.168.20.1 |

## 🔧 Configuration Steps

### 1. Switch Configuration

**Create VLANs:**
```cisco
vlan 10
 name Sales
vlan 20
 name IT
```

**Assign ports to VLANs:**
```cisco
interface range FastEthernet 0/1-2
 switchport mode access
 switchport access vlan 10

interface range FastEthernet 0/3-4
 switchport mode access
 switchport access vlan 20
```

**Configure trunk to router:**
```cisco
interface GigabitEthernet 0/1
 switchport mode trunk
 switchport trunk allowed vlan 10,20
```

### 2. Router Configuration (Router-on-a-Stick)

**Enable main interface:**
```cisco
interface GigabitEthernet 0/0
 no shutdown
```

**Create sub-interfaces for each VLAN:**
```cisco
interface GigabitEthernet 0/0.10
 encapsulation dot1Q 10
 ip address 192.168.10.1 255.255.255.0

interface GigabitEthernet 0/0.20
 encapsulation dot1Q 20
 ip address 192.168.20.1 255.255.255.0
```

## ✅ Verification & Testing

### Verification Commands

**On Switch:**
```cisco
show vlan brief              # Verify VLAN creation and assignments
show interfaces trunk        # Verify trunk configuration
show running-config          # Review full configuration
```

**On Router:**
```cisco
show ip interface brief      # Verify sub-interfaces are up
show ip route                # Check routing table (should show connected networks)
show running-config          # Review configuration
```

### Test Connectivity

**From PC1 (VLAN 10):**
```
ping 192.168.10.11    # PC2 (same VLAN) - Should succeed (Layer 2 switching)
ping 192.168.20.10    # PC3 (different VLAN) - Should succeed (Layer 3 routing)
tracert 192.168.20.10 # Should show hop through router (192.168.10.1)
```

## 📚 Concepts Demonstrated

### 1. VLANs (Virtual LANs)
- **Purpose**: Segment broadcast domains logically (not physically)
- **Benefit**: Improved security, reduced broadcast traffic, logical grouping
- **VLAN 10 (Sales)**: Contains PC1 and PC2
- **VLAN 20 (IT)**: Contains PC3 and PC4

### 2. Trunk Links (802.1Q)
- Carries traffic for multiple VLANs between switch and router
- Uses VLAN tagging to identify which VLAN each frame belongs to
- Command: `switchport mode trunk`

### 3. Router-on-a-Stick
- Single physical router interface with multiple logical sub-interfaces
- Each sub-interface acts as default gateway for one VLAN
- **Advantage**: Cost-effective (only need one router interface)
- **Disadvantage**: Potential bottleneck (all traffic uses one link)

### 4. Inter-VLAN Routing
- **Problem**: Devices in different VLANs can't communicate by default
- **Solution**: Route traffic between VLANs using router
- Traffic flow: PC1 → Switch → Router → Switch → PC3

## 🔍 How It Works

1. **Intra-VLAN Communication** (PC1 to PC2):
   - Layer 2 switching only
   - Traffic stays within VLAN 10
   - No router involvement

2. **Inter-VLAN Communication** (PC1 to PC3):
   - PC1 sends packet to default gateway (192.168.10.1)
   - Switch forwards to router via trunk (tagged as VLAN 10)
   - Router receives on sub-interface G0/0.10
   - Router routes to G0/0.20 (VLAN 20)
   - Switch receives packet (tagged as VLAN 20)
   - Switch forwards to PC3 in VLAN 20

## 🐛 Troubleshooting Guide

| Issue | Possible Causes | Solution |
|-------|----------------|----------|
| No intra-VLAN communication | Incorrect VLAN assignment | Check `show vlan brief` |
| No inter-VLAN communication | Router interface down | `no shutdown` on G0/0 |
| Trunk not working | VLAN not allowed on trunk | `switchport trunk allowed vlan 10,20` |
| Sub-interface down | Missing encapsulation | Add `encapsulation dot1Q [vlan-id]` |
| Wrong gateway | PC misconfigured | Verify default gateway matches sub-interface IP |

## 📊 Expected Results

✅ **Layer 2 Communication**: PCs in same VLAN communicate directly via switch
✅ **Layer 3 Routing**: PCs in different VLANs communicate through router
✅ **Trunk Functionality**: Single link carries multiple VLAN traffic
✅ **Scalability**: Easy to add more VLANs with additional sub-interfaces

## 🎓 What I Learned

- How VLANs segment broadcast domains for security and efficiency
- Difference between access ports and trunk ports
- 802.1Q VLAN tagging mechanism
- Router-on-a-stick configuration using sub-interfaces
- Inter-VLAN routing process and packet flow
- Proper verification techniques using show commands
- Troubleshooting VLAN and routing issues

## 🏷️ Skills Demonstrated

`VLANs` `Trunking` `802.1Q` `Inter-VLAN Routing` `Router-on-a-Stick` `Cisco IOS` `Switching` `Routing` `Network Segmentation` `Troubleshooting`

## 📁 Files Included

- `network-config.txt` - Complete configuration for switch and router
- `topology-diagram.png` - Visual network topology (add your Packet Tracer screenshot)
- `README.md` - This documentation
- `lab.pkt` - Packet Tracer file (if available)

## 🚀 Try It Yourself

1. Open Cisco Packet Tracer
2. Create the topology as shown
3. Apply configurations from `network-config.txt`
4. Test connectivity using ping and tracert
5. Experiment: Add a third VLAN and configure routing for it!
