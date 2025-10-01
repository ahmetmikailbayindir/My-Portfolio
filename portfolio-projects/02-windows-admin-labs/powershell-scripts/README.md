# PowerShell Automation Scripts

## 📋 Overview

Collection of PowerShell scripts for automating common Windows Server administration tasks, specifically focused on Active Directory management.

## 📜 Scripts Included

### 1. Create-BulkUsers.ps1

**Purpose**: Automate creation of multiple Active Directory user accounts from CSV file

**Features**:
- CSV-based bulk user import
- Input validation and error handling
- Duplicate user detection
- OU verification
- Detailed logging and summary report
- Secure password handling

**Usage**:
```powershell
# Run with default password
.\Create-BulkUsers.ps1 -CSVPath ".\users-sample.csv"

# Run with custom secure password
$SecurePass = Read-Host "Enter password" -AsSecureString
.\Create-BulkUsers.ps1 -CSVPath ".\users.csv" -DefaultPassword $SecurePass
```

**CSV Format**:
```csv
FirstName,LastName,Username,Email,Department,OU
John,Doe,jdoe,jdoe@company.local,IT,"OU=IT,DC=company,DC=local"
```

**Output Example**:
```
Processing user: jdoe
✓ Successfully created user: jdoe

========================================
         Bulk User Creation Summary
========================================
Total users processed: 50
Successfully created: 48
Failed: 0
Skipped: 2
========================================
```

## 🔧 Technical Highlights

### Error Handling
```powershell
# Check if user already exists
try {
    $ExistingUser = Get-ADUser -Identity $Username -ErrorAction SilentlyContinue
    if ($ExistingUser) {
        Write-Warning "User $Username already exists - Skipping"
        $SkipCount++
        continue
    }
}
catch {
    # User doesn't exist - proceed
}
```

### Input Validation
```powershell
# Validate required fields
if ([string]::IsNullOrWhiteSpace($Username) -or
    [string]::IsNullOrWhiteSpace($FirstName) -or
    [string]::IsNullOrWhiteSpace($LastName)) {
    Write-Warning "Skipping user - Missing required fields"
    $SkipCount++
    continue
}
```

### Secure Password Handling
```powershell
# Convert plain text to SecureString
$DefaultPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force

# Or prompt user for secure input
$SecurePass = Read-Host "Enter password" -AsSecureString
```

### Parameter Splatting
```powershell
# Clean, maintainable parameter passing
$UserParams = @{
    SamAccountName        = $Username
    UserPrincipalName     = $Email
    Name                  = "$FirstName $LastName"
    GivenName             = $FirstName
    Surname               = $LastName
    EmailAddress          = $Email
    Department            = $Department
    Path                  = $OU
    AccountPassword       = $DefaultPassword
    Enabled               = $true
    ChangePasswordAtLogon = $true
}

New-ADUser @UserParams -ErrorAction Stop
```

## 📚 What I Learned

- **PowerShell Fundamentals**
  - Parameter declaration and validation
  - Error handling with try/catch
  - Module importing

- **Active Directory Automation**
  - Using ActiveDirectory PowerShell module
  - User creation with New-ADUser
  - OU verification and validation

- **Best Practices**
  - Secure password handling
  - Input validation
  - Comprehensive error reporting
  - Code documentation with comment-based help
  - Parameter splatting for readability

- **Professional Scripting**
  - Progress tracking and counters
  - Color-coded output for user experience
  - Summary reports
  - CSV data processing

## 🚀 Real-World Applications

This script solves the common IT problem of:
- Onboarding new employees in bulk (e.g., start of semester, new hires)
- Migrating users between systems
- Setting up lab environments
- Disaster recovery user restoration

**Time Savings**: Creating 50 users manually takes ~2 hours. This script completes it in under 2 minutes.

## 🧪 Testing Checklist

- [x] Valid CSV with all required fields
- [x] CSV with missing fields (validation test)
- [x] Duplicate username (skip test)
- [x] Non-existent OU (fallback test)
- [x] Invalid CSV path (error handling)
- [x] Empty CSV file
- [x] Large dataset (100+ users)

## 🎯 Possible Enhancements

- [ ] Email notification upon completion
- [ ] Generate random secure passwords per user
- [ ] Add users to security groups based on department
- [ ] Create home directories automatically
- [ ] Set profile pictures from photos folder
- [ ] Export results to log file
- [ ] Add rollback functionality

## 🏷️ Skills Demonstrated

`PowerShell` `Active Directory` `Automation` `Scripting` `CSV Processing` `Error Handling` `Input Validation` `Bulk Operations` `IT Efficiency`

## 📖 Prerequisites

- Windows Server with Active Directory Domain Services
- PowerShell 5.1 or higher
- ActiveDirectory PowerShell module installed
- Domain Administrator or delegated permissions
- CSV file with proper format

## 💡 Usage Tips

1. Always test with a small sample CSV first
2. Backup Active Directory before bulk operations
3. Review the summary report carefully
4. Use strong default passwords
5. Consider using separate OUs for testing
