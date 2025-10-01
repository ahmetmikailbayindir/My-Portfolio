#Requires -Modules ActiveDirectory

<#
.SYNOPSIS
    Bulk user creation script for Active Directory

.DESCRIPTION
    This script creates multiple user accounts in Active Directory from a CSV file.
    It includes validation, error handling, and creates users in specified OUs.

.PARAMETER CSVPath
    Path to CSV file containing user information

.PARAMETER DefaultPassword
    Default password for new users (requires SecureString)

.EXAMPLE
    .\Create-BulkUsers.ps1 -CSVPath ".\users.csv"

.NOTES
    Author: Ahmet Mikail Bayindir
    Course: CST8342 - Windows Administration
    Date: October 2025
    Requires: Active Directory PowerShell module
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$CSVPath,

    [Parameter(Mandatory=$false)]
    [SecureString]$DefaultPassword
)

# Import Active Directory module
Import-Module ActiveDirectory -ErrorAction Stop

# Set default password if not provided
if (-not $DefaultPassword) {
    $DefaultPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force
}

# Verify CSV file exists
if (-not (Test-Path $CSVPath)) {
    Write-Error "CSV file not found: $CSVPath"
    exit 1
}

# Import user data from CSV
# Expected columns: FirstName, LastName, Username, Email, Department, OU
try {
    $Users = Import-Csv -Path $CSVPath
    Write-Host "Successfully imported $($Users.Count) users from CSV" -ForegroundColor Green
}
catch {
    Write-Error "Failed to import CSV: $_"
    exit 1
}

# Counter variables
$SuccessCount = 0
$FailCount = 0
$SkipCount = 0

# Process each user
foreach ($User in $Users) {
    $Username = $User.Username
    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Email = $User.Email
    $Department = $User.Department
    $OU = $User.OU

    Write-Host "`nProcessing user: $Username" -ForegroundColor Cyan

    # Validate required fields
    if ([string]::IsNullOrWhiteSpace($Username) -or
        [string]::IsNullOrWhiteSpace($FirstName) -or
        [string]::IsNullOrWhiteSpace($LastName)) {
        Write-Warning "Skipping user - Missing required fields (Username, FirstName, or LastName)"
        $SkipCount++
        continue
    }

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
        # User doesn't exist - this is expected
    }

    # Verify OU exists
    try {
        $OUExists = Get-ADOrganizationalUnit -Identity $OU -ErrorAction Stop
    }
    catch {
        Write-Warning "OU not found: $OU - Using default Users container"
        $OU = "CN=Users," + (Get-ADDomain).DistinguishedName
    }

    # Create user account
    try {
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
            PasswordNeverExpires  = $false
        }

        New-ADUser @UserParams -ErrorAction Stop
        Write-Host "✓ Successfully created user: $Username" -ForegroundColor Green
        $SuccessCount++
    }
    catch {
        Write-Error "Failed to create user $Username : $_"
        $FailCount++
    }
}

# Display summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "         Bulk User Creation Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total users processed: $($Users.Count)" -ForegroundColor White
Write-Host "Successfully created: $SuccessCount" -ForegroundColor Green
Write-Host "Failed: $FailCount" -ForegroundColor Red
Write-Host "Skipped: $SkipCount" -ForegroundColor Yellow
Write-Host "========================================`n" -ForegroundColor Cyan
