# JoanLab - Active Directory Bulk User Creation Tool

A PowerShell-based GUI tool for automating Active Directory user creation from a CSV file.
Built as part of a home lab project to practice AD administration and PowerShell scripting.

## Features

- GUI interface with CSV file browser
- Bulk user creation from CSV input
- Random password generation per user
- Automatic security group assignment based on department
- Timestamped export of created users with credentials
- Timestamped export of failed users with failure reason
- Error handling for duplicate users and missing OUs
- Forces password change on first login

## Prerequisites

- Windows Server with Active Directory Domain Services
- PowerShell Active Directory module
- Domain: joanlab.local

## File Structure
Scripts/
├── Create-BulkUsers.ps1    # Main GUI script
├── Functions.ps1           # Core functions
└── README.md               # This file

## CSV Format

The input CSV must have the following headers:
id, first_name, last_name, Department, Title

Departments must match exactly:
- `IT`
- `HR`
- `Sales`
- `Customer_Service`

## OU Structure
DC=joanlab,DC=local
└── My Lab
└── Lab Users
├── IT
├── HR
├── Sales
├── Customer_Service
├── Admins
└── Service Accounts

## Security Groups

Users are automatically assigned to their department security group:

| Department | Security Group |
|---|---|
| IT | SG_IT |
| HR | SG_HR |
| Sales | SG_Sales |
| Customer_Service | SG_Customer_Service |

## Output Files

Saved to `Documents\` with timestamp:

| File | Description |
|---|---|
| `created_users_YYYY-MM-DD_HH-mm-ss.csv` | Successfully created users with credentials |
| `failed_users_YYYY-MM-DD_HH-mm-ss.csv` | Failed users with failure reason |

## How to Run

1. Place `Create-BulkUsers.ps1` and `Functions.ps1` in the same folder
2. Open PowerShell as Administrator
3. Set execution policy if needed:
```powershell
Set-ExecutionPolicy RemoteSigned
```
4. Run the script:
```powershell
.\Create-BulkUsers.ps1
```
5. Click **Browse** to select your CSV file
6. Click **Create Users** to run
7. Check your Documents folder for output files

## Author
Joan Estepan
