# Windows Enterprise Administration Labs (CST8342)

> Hands-on projects demonstrating Windows Server administration, Active Directory, Exchange Server, and PowerShell automation.

## 📋 Overview

This repository showcases practical Windows Server administration skills developed during the CST8342 Windows Administration course at Algonquin College. Projects include Active Directory management, Exchange Server configuration, DNS administration, and PowerShell automation.

## 🎯 Projects Included

### 1. Active Directory & Group Policy
- **Description**: Complete AD infrastructure with OUs, users, groups, and GPOs
- **Skills**: Active Directory, Group Policy, organizational design
- **Location**: [active-directory/](active-directory/)

### 2. Exchange Server Configuration
- **Description**: Email server setup with protocols and SPF records
- **Skills**: Exchange Server, SMTP/POP3/IMAP, DNS configuration
- **Location**: [exchange-server/](exchange-server/)

### 3. DNS Administration
- **Description**: DNS server configuration with forward/reverse zones and SPF records
- **Skills**: DNS zones, record types, email security
- **Location**: [dns-administration/](dns-administration/)

### 4. PowerShell Automation Scripts
- **Description**: Collection of administrative automation scripts
- **Skills**: PowerShell scripting, automation, bulk operations
- **Location**: [powershell-scripts/](powershell-scripts/)

## 🛠️ Technologies Used

- **OS**: Windows Server 2019/2022
- **Services**: Active Directory Domain Services, DNS, Exchange Server
- **Tools**: PowerShell, Server Manager, ADUC, Group Policy Management
- **Virtualization**: VMware Workstation / Hyper-V

## 🏗️ Lab Environment

- Domain Controller: Windows Server 2022
- Exchange Server: Windows Server 2019
- Client Machines: Windows 10/11 Pro
- Network: Private virtual network with NAT

## 🚀 Key Accomplishments

- ✅ Designed and deployed Active Directory forest with 3 OUs
- ✅ Created 50+ user accounts using PowerShell automation
- ✅ Configured Group Policies for security and desktop management
- ✅ Set up Exchange Server with multiple mailboxes
- ✅ Implemented SPF records for email authentication
- ✅ Automated repetitive tasks with PowerShell scripts

## 📚 What I Learned

This course transformed how I think about Windows administration:

- **Enterprise-level Windows Server** - I learned to manage servers the way large organizations do, not just home setups
- **Active Directory architecture** - Understanding domains, OUs, and trust relationships made sense of how companies structure their IT
- **Group Policy for control** - GPOs let me enforce security and configuration across hundreds of machines from one place
- **Exchange Server complexity** - Email isn't simple - I learned about protocols, authentication, and spam protection
- **DNS is everything** - Almost every service depends on DNS working correctly, so I mastered forward zones, reverse zones, and record types
- **PowerShell automation** - Creating 50 users manually takes hours; with PowerShell it takes seconds
- **Documentation discipline** - I learned to document everything because I'll forget the details later

### Why This Matters

At **OISO** (2023-2024), we managed user accounts through Active Directory. Understanding AD structure helped me troubleshoot permission issues faster and create proper security groups instead of giving everyone admin rights.

The PowerShell bulk user creation script directly relates to onboarding new employees. At **Kelesoglu IT** (2017-2019), we created accounts manually one-by-one - it was tedious and error-prone. Now I know how to automate it properly with CSV imports and parameter validation.

### Real-World Impact

The Group Policy knowledge saved me at OISO when I needed to:
- Deploy software to 50+ workstations simultaneously
- Enforce password policies across the organization
- Configure desktop wallpapers and security settings centrally

Without GPOs, I would have been configuring each machine individually. With GPOs, I configured it once and it applied everywhere.

## 📸 Documentation

Each project folder contains:
- Detailed setup instructions I wrote while building the labs
- PowerShell scripts (fully commented so I remember how they work)
- Network diagrams showing the topology
- Screenshots proving the configurations work
- Configuration files and exports for reference

## 🏷️ Skills Demonstrated

`Windows Server` `Active Directory` `Group Policy` `Exchange Server` `DNS` `PowerShell` `Automation` `Enterprise IT` `System Administration`

## 👤 About This Project

**Created by**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking
**Institution**: Algonquin College
**Course**: CST8342 - Windows Enterprise Administration

### What I Built

I built a complete Windows enterprise environment from scratch:
- **Active Directory forest** with proper OU structure (not just dumping everything in Users)
- **50+ user accounts** created via PowerShell automation (with proper error handling)
- **Group Policies** for security, desktop management, and software deployment
- **Exchange Server** with mailboxes, protocols, and SPF records
- **DNS infrastructure** supporting all services with proper forward/reverse zones

This is the foundation every IT department runs on. These aren't theoretical exercises - this is what I'll be managing in my career.

## 📄 License

This project is for educational purposes as part of the CST8342 course curriculum.
