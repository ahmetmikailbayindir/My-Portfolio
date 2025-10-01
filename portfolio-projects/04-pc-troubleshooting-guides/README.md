# PC Troubleshooting Guides (CST8316)

> Professional documentation and how-to guides for hardware diagnostics and OS troubleshooting across Windows, Linux, and MacOS.

## 📋 Overview

This repository contains comprehensive troubleshooting guides, diagnostic procedures, and how-to documentation developed during the CST8316 PC Troubleshooting course at Algonquin College. Each guide follows professional documentation standards and provides step-by-step solutions to common IT support scenarios.

## 🛠️ Troubleshooting Guides Included

### Hardware Diagnostics
1. **[Boot Failure Diagnostics](hardware/boot-failure-guide.md)** - POST codes, BIOS issues, hardware failures
2. **[Memory (RAM) Testing & Replacement](hardware/ram-troubleshooting.md)** - Memory errors, testing procedures, replacement
3. **[Hard Drive Diagnostics](hardware/hdd-diagnostics.md)** - SMART errors, disk failure, data recovery
4. **[Overheating Issues](hardware/thermal-troubleshooting.md)** - Temperature monitoring, cooling solutions

### Windows Troubleshooting
1. **[Blue Screen of Death (BSOD) Resolution](windows/bsod-troubleshooting.md)** - Error code analysis, driver issues
2. **[Windows Boot Repair](windows/boot-repair-guide.md)** - Startup repair, BCD rebuilding, recovery options
3. **[Performance Optimization](windows/performance-optimization.md)** - Slow system fixes, resource management
4. **[Network Connectivity Issues](windows/network-troubleshooting.md)** - TCP/IP reset, driver issues, DNS problems

### Linux Troubleshooting
1. **[GRUB Bootloader Repair](linux/grub-repair-guide.md)** - Boot issues, GRUB rescue mode
2. **[Package Management Issues](linux/package-troubleshooting.md)** - APT/YUM errors, dependency conflicts
3. **[Permissions & Ownership Fixes](linux/permissions-guide.md)** - File access, chmod/chown usage

### MacOS Troubleshooting
1. **[Mac Won't Boot Solutions](macos/boot-troubleshooting.md)** - Recovery mode, safe boot, NVRAM reset
2. **[Application Crashes](macos/app-crash-resolution.md)** - Force quit, cache clearing, reinstallation

## 📚 Documentation Standards

All guides follow professional IT documentation practices:

- ✅ **Clear Problem Statement** - What issue does this guide address?
- ✅ **Symptoms Checklist** - How to identify the problem
- ✅ **Step-by-Step Solutions** - Numbered, easy-to-follow instructions
- ✅ **Screenshots/Visuals** - Visual aids where helpful
- ✅ **Verification Steps** - How to confirm the fix worked
- ✅ **Troubleshooting Tips** - What to do if solution doesn't work
- ✅ **Prevention Tips** - How to avoid the issue in the future

## 🔧 Tools & Utilities Referenced

### Diagnostic Tools
- **Windows**: Event Viewer, Performance Monitor, Reliability Monitor, SFC, DISM
- **Linux**: dmesg, journalctl, top, htop, smartctl, fsck
- **MacOS**: Disk Utility, Activity Monitor, Console, First Aid
- **Universal**: MemTest86, CrystalDiskInfo, CPU-Z, GPU-Z, HWMonitor

### Command-Line Utilities
- Windows: `sfc /scannow`, `chkdsk`, `DISM`, `netsh`
- Linux: `fsck`, `apt-get`, `systemctl`, `chmod`, `chown`
- MacOS: `diskutil`, `fsck`, `nvram`

## 🎯 Common Troubleshooting Methodology

### Step 1: Identify the Problem
- Gather information from user
- Observe symptoms and error messages
- Review recent changes (software, hardware, updates)

### Step 2: Research & Hypothesize
- Check error codes/messages
- Consult documentation
- Form theory of probable cause

### Step 3: Test & Implement
- Test hypothesis with least invasive solution first
- Document steps taken
- Implement fix

### Step 4: Verify & Document
- Confirm issue is resolved
- Test all functionality
- Document solution for future reference

## 📊 Real-World Scenarios

### Scenario 1: Slow Windows 10 Performance
**Symptoms**: Sluggish startup, high disk usage, frozen applications

**Solution Path**:
1. Check Task Manager → Disk usage at 100%
2. Identify Windows Search Indexer as culprit
3. Rebuild search index or disable for non-essential drives
4. Verify improvement with Performance Monitor

### Scenario 2: Linux System Won't Boot After Update
**Symptoms**: GRUB rescue prompt, kernel panic

**Solution Path**:
1. Boot from live USB
2. Mount system partition
3. Chroot into system
4. Reinstall GRUB bootloader
5. Update GRUB configuration
6. Reboot and verify

## 🏷️ Skills Demonstrated

`Hardware Diagnostics` `Windows Troubleshooting` `Linux Administration` `MacOS Support` `Technical Documentation` `Problem Solving` `IT Support` `Help Desk` `Customer Service` `IEEE Documentation Standards`

## 📝 Documentation Format

Each guide includes:

```markdown
# [Problem Title]

## Symptoms
- List of observable issues

## Causes
- Common root causes

## Solution
Step-by-step instructions with commands/screenshots

## Verification
How to confirm the fix

## Prevention
Best practices to avoid recurrence
```

## 🎓 What I Learned

### Technical Skills I Developed

- **Systematic troubleshooting** - I learned to follow a logical process instead of randomly trying fixes
- **OS-specific diagnostic tools** - Event Viewer for Windows, dmesg for Linux, Console for MacOS
- **Hardware diagnostics** - Identifying failing RAM, dying hard drives, thermal issues before they cause data loss
- **Command-line mastery** - `sfc /scannow`, `DISM`, `fsck`, `chkdsk` became part of my troubleshooting toolkit
- **Data backup and recovery** - Always backup first, because troubleshooting can sometimes make things worse

### Professional Skills That Transfer Everywhere

- **Technical writing clarity** - Writing guides that non-technical users can follow
- **IEEE documentation standards** - Professional formatting that looks polished
- **Breaking down complexity** - Explaining technical problems in plain language
- **Customer service mindset** - Understanding that frustrated users need patience and clear guidance
- **Time management** - Prioritizing critical issues (data loss) over minor annoyances (slow startup)

### Why This Course Was Critical

At **OISO** (2023-2024), I dealt with support tickets daily. This course taught me to:
- **Document solutions properly** so I don't have to re-solve the same problem next week
- **Use Event Viewer** to diagnose Windows BSODs instead of guessing
- **Fix boot issues** without reinstalling the entire OS

At **Kelesoglu IT** (2017-2019), I learned hardware troubleshooting through trial and error. This course formalized that knowledge:
- **POST codes** tell you exactly what's failing during boot
- **MemTest86** definitively proves whether RAM is bad
- **SMART errors** warn you before hard drives completely fail

### Real Problems I Can Now Solve

1. **Windows won't boot** → I know how to use Startup Repair, rebuild BCD, and restore from System Restore
2. **Linux kernel panic** → I can chroot from live USB and fix GRUB
3. **Mac stuck on Apple logo** → NVRAM reset, safe boot, recovery mode - I know the progression
4. **Random BSODs** → Event Viewer + error codes lead me straight to the driver or hardware causing crashes
5. **Slow performance** → Task Manager + Performance Monitor show me exactly what's bottlenecking

This isn't theory - these are issues I encountered at OISO, and now I have documented procedures for solving them.

## 👤 About This Project

**Created by**: Ahmet Mikail Bayindir
**Program**: Computer Systems Technician - Networking
**Institution**: Algonquin College
**Course**: CST8316 - PC Troubleshooting

### What I Built

I created a comprehensive troubleshooting knowledge base covering:
- **Hardware diagnostics** - Boot failures, RAM issues, hard drive failures, thermal problems
- **Windows troubleshooting** - BSODs, boot repair, performance optimization, network issues
- **Linux troubleshooting** - GRUB repair, package management, permissions
- **MacOS troubleshooting** - Boot issues, application crashes

These aren't just guides I copied from the internet. I wrote them based on problems I actually solved in labs and real-world experience. Each guide follows professional IEEE documentation standards because that's how real IT departments document procedures.

### Why Documentation Matters

At OISO, we didn't have good documentation. Every time someone encountered a problem, they'd ask around or Google it again. I wasted hours re-solving problems I'd already fixed before.

Now I understand: **good documentation turns every problem you solve into knowledge the whole team can use**. That's why I structured these guides with clear symptoms, step-by-step solutions, verification steps, and prevention tips.

## 📄 License

This project is for educational purposes as part of the CST8316 course curriculum.

---

## 💡 How to Use These Guides

1. Browse the category folders (hardware/, windows/, linux/, macos/)
2. Select the guide matching your issue
3. Follow the step-by-step instructions
4. Check verification steps to ensure resolution
5. Implement prevention tips to avoid recurrence

**Note**: Always backup important data before performing troubleshooting steps that modify system files or configurations.
