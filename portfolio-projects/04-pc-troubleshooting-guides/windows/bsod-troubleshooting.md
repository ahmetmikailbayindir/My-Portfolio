# Blue Screen of Death (BSOD) Troubleshooting Guide

## 📌 Problem Statement

Windows displays a blue screen with a stop code/error message and automatically restarts, causing data loss and system instability.

## 🔍 Symptoms

- Computer crashes to blue screen during use or startup
- System automatically reboots after showing error
- Stop code displayed (e.g., SYSTEM_SERVICE_EXCEPTION, PAGE_FAULT_IN_NONPAGED_AREA)
- May show driver file name (e.g., ntfs.sys, win32k.sys)
- Recurring crashes at specific actions or random intervals

## 🎯 Common Causes

1. **Driver Issues** (60% of BSODs)
   - Outdated, corrupted, or incompatible drivers
   - Recent driver update causing conflicts

2. **Hardware Problems** (25% of BSODs)
   - Faulty RAM
   - Overheating components
   - Failing hard drive or SSD

3. **Software Conflicts** (10% of BSODs)
   - Malware or virus
   - Corrupted system files
   - Recent software installation

4. **Other** (5%)
   - Windows updates causing conflicts
   - Overclocking instability

## 🛠️ Solution Steps

### Phase 1: Gather Information

#### Step 1: Record the Stop Code
When BSOD appears, note down:
- Stop code (e.g., `0x0000007B`)
- Error name (e.g., `DRIVER_IRQL_NOT_LESS_OR_EQUAL`)
- Driver file mentioned (if any, e.g., `nvlddmkm.sys`)

**If screen disappears too quickly:**
1. Right-click **This PC** → **Properties**
2. Click **Advanced system settings**
3. Under **Startup and Recovery**, click **Settings**
4. **Uncheck** "Automatically restart"
5. Click **OK**

This allows you to read the full BSOD message.

#### Step 2: Check Windows Event Viewer
1. Press `Win + X` → Select **Event Viewer**
2. Navigate to **Windows Logs** → **System**
3. Look for **Critical** errors near the time of crash
4. Double-click errors to see details
5. Note any driver or service names mentioned

### Phase 2: Quick Fixes

#### Step 3: Boot into Safe Mode
1. **Method 1 (From sign-in screen)**:
   - Hold **Shift** + Click **Restart**
   - Choose **Troubleshoot** → **Advanced options** → **Startup Settings** → **Restart**
   - Press **F4** for Safe Mode or **F5** for Safe Mode with Networking

2. **Method 2 (Windows won't boot)**:
   - Force shutdown 3 times during boot to trigger Automatic Repair
   - Follow same path as Method 1

#### Step 4: Uninstall Recent Updates/Software
If BSODs started after recent changes:

**Uninstall Recent Software:**
1. Open **Settings** → **Apps** → **Apps & features**
2. Sort by **Install date**
3. Uninstall recently installed programs
4. Restart and test

**Uninstall Windows Updates:**
1. **Settings** → **Update & Security** → **View update history**
2. Click **Uninstall updates**
3. Right-click problematic update → **Uninstall**
4. Restart

#### Step 5: Update or Rollback Drivers
**If driver name was shown in BSOD:**

1. Press `Win + X` → **Device Manager**
2. Locate the device (use filename to identify):
   - `nvlddmkm.sys` = NVIDIA graphics
   - `igdkmd64.sys` = Intel graphics
   - `atikmdag.sys` = AMD graphics
   - `netwtw10.sys` = Wireless network adapter

3. Right-click device → **Properties** → **Driver** tab

**Option A: Update Driver**
   - Click **Update Driver** → **Search automatically**

**Option B: Rollback Driver** (if recently updated)
   - Click **Roll Back Driver**
   - Select reason → **Yes**
   - Restart computer

**Option C: Reinstall Driver**
   - Click **Uninstall Device** (check "Delete driver software")
   - Restart (Windows will reinstall driver)

### Phase 3: Advanced Troubleshooting

#### Step 6: Run System File Checker (SFC)
1. Press `Win + X` → **Command Prompt (Admin)** or **PowerShell (Admin)**
2. Type: `sfc /scannow`
3. Wait 15-30 minutes for completion
4. If errors found: `DISM /Online /Cleanup-Image /RestoreHealth`
5. Run `sfc /scannow` again
6. Restart computer

#### Step 7: Check for Malware
1. Download **Malwarebytes** (free version)
2. Run full system scan
3. Quarantine/delete any threats found
4. Restart and test

#### Step 8: Test RAM (Memory Diagnostic)
1. Press `Win + R` → Type `mdsched.exe` → **Enter**
2. Choose **Restart now and check for problems**
3. Computer will restart and run memory test (10-20 minutes)
4. Review results after reboot

**If errors found:**
   - Reseat RAM sticks
   - Test one stick at a time to identify faulty module
   - Replace faulty RAM

#### Step 9: Check Disk for Errors
1. Open **Command Prompt (Admin)**
2. Type: `chkdsk C: /f /r`
3. Press **Y** when prompted to schedule on next restart
4. Restart computer
5. Scan will run on boot (may take 1-2 hours)

#### Step 10: Check for Overheating
1. Download **HWMonitor** or **Core Temp**
2. Monitor CPU/GPU temperatures during normal use
3. If temperatures exceed:
   - CPU: 80-85°C under load
   - GPU: 85-90°C under load

**Solutions for overheating:**
   - Clean dust from vents and fans
   - Reapply thermal paste
   - Improve case airflow
   - Replace failing fans

### Phase 4: Last Resort Solutions

#### Step 11: System Restore
1. Press `Win + R` → Type `rstrui.exe` → **Enter**
2. Choose a restore point from before BSODs started
3. Click **Next** → **Finish**
4. System will restore and restart

#### Step 12: Reset Windows (Keep Files)
1. **Settings** → **Update & Security** → **Recovery**
2. Under **Reset this PC**, click **Get started**
3. Choose **Keep my files**
4. Follow prompts to reset Windows
5. Reinstall applications after reset

## ✅ Verification Steps

After applying fixes:
1. Restart computer 3-5 times to ensure stability
2. Run stress tests:
   - Open multiple applications
   - Play games or run demanding software
   - Leave computer on overnight
3. Monitor for 24-48 hours of normal use
4. Check Event Viewer for any new Critical errors

## 🚫 Prevention Tips

1. **Keep Drivers Updated**
   - Use Windows Update regularly
   - Check manufacturer websites for driver updates
   - Use **Driver Booster** or **Snappy Driver Installer** cautiously

2. **Regular Maintenance**
   - Run `sfc /scannow` monthly
   - Keep antivirus updated and scan weekly
   - Clean physical dust from computer every 3-6 months

3. **Avoid Overclocking** (unless experienced)

4. **Monitor Hardware Health**
   - Check SMART status of drives monthly
   - Monitor temperatures periodically

5. **Create System Restore Points**
   - Before major updates
   - Before installing new drivers
   - Monthly as precaution

6. **Backup Important Data**
   - Use cloud storage (OneDrive, Google Drive)
   - External hard drive backups
   - Enable File History in Windows

## 📊 Common BSOD Error Codes

| Stop Code | Error Name | Common Cause | Quick Fix |
|-----------|-----------|--------------|-----------|
| 0x0000007B | INACCESSIBLE_BOOT_DEVICE | Hard drive/controller driver | Boot repair, check SATA mode (AHCI/IDE) |
| 0x0000007E | SYSTEM_THREAD_EXCEPTION | Driver crash | Update/rollback driver |
| 0x0000000A | IRQL_NOT_LESS_OR_EQUAL | Driver accessing memory | Update network/graphics driver |
| 0x00000050 | PAGE_FAULT_IN_NONPAGED_AREA | Faulty RAM or driver | Test RAM, update drivers |
| 0x000000D1 | DRIVER_IRQL_NOT_LESS_OR_EQUAL | Network driver issue | Update network adapter driver |
| 0x000000F4 | CRITICAL_OBJECT_TERMINATION | Critical process crash | SFC scan, malware check |
| 0x0000003B | SYSTEM_SERVICE_EXCEPTION | Driver or service fault | Update drivers, SFC scan |
| 0x00000124 | WHEA_UNCORRECTABLE_ERROR | Hardware failure | Check CPU, RAM, overheating |

## 🆘 When to Seek Professional Help

Contact a technician if:
- BSODs persist after all troubleshooting steps
- Multiple different stop codes occur
- Hardware tests show failures (RAM, HDD)
- Computer is under warranty
- Not comfortable opening computer case

## 📖 Additional Resources

- [Microsoft BSOD Reference](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/bug-check-code-reference2)
- [BlueScreenView Tool](https://www.nirsoft.net/utils/blue_screen_view.html) - Analyzes minidump files
- [WhoCrashed](https://www.resplendence.com/whocrashed) - Automatic crash dump analysis

## 🏷️ Skills Applied

`Windows Troubleshooting` `Driver Management` `System File Checker` `Event Viewer` `Safe Mode` `Hardware Diagnostics` `Memory Testing` `Technical Support`

---

**Document Version**: 1.0
**Last Updated**: October 2025
**Author**: Ahmet Mikail Bayindir
**Course**: CST8316 - PC Troubleshooting
