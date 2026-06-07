# Active Directory Backup and Recovery

## Overview
Configured AD backup and recovery using Windows Server Backup and the AD Recycle Bin. This covers both preventing data loss and recovering from accidental deletions.

## Environment
- **Domain Controller:** `WIN-89H2KGSP59Q`
- **OS:** Windows Server 2025

## What Was Built

### AD Recycle Bin
- Enabled via Active Directory Administrative Center
- Tested by deleting a user and restoring them from the Deleted Objects container
- Restores user with all attributes intact — group memberships, UPN, department

### Windows Server Backup
- Installed via Server Manager
- System state backup completed to `\\WIN-89H2KGSP59Q\Shares`
- Verified via `wbadmin get versions`

## Key Concepts
- **AD Recycle Bin** allows recovery of deleted AD objects within a tombstone lifetime window (default 180 days) without needing to restore from backup
- **System State backup** captures AD database (NTDS.dit), SYSVOL, registry, and boot files — everything needed to restore a DC
- **wbadmin** is the command-line tool for Windows Server Backup — useful for scripting and verifying backup status

## Commands Used
```powershell
# Verify backup versions
wbadmin get versions

# Restore deleted AD user (run in AD module)
Get-ADObject -Filter {DisplayName -eq "John Doe"} -IncludeDeletedObjects | Restore-ADObject
```

## Screenshots
- `RecycleBin_AdminCenter.png`
- `RecycleBin_DeletedUser.png`
- `RecycleBin_Restored.png`
- `Backup_wbadmin.png`
- `Backup_Console.png`
