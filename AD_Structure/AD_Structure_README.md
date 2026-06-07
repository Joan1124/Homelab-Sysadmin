# Active Directory Structure

## Overview
Built a full Active Directory domain from scratch on Windows Server 2025. This covers the OU hierarchy, user accounts, and security group structure that forms the foundation of the lab.

## Environment
- **Domain:** `joanlab.local`
- **Domain Controller:** `WIN-89H2KGSP59Q` — `192.168.100.1`
- **OS:** Windows Server 2025

## What Was Built
### Organizational Units
- `My Lab > Lab Users > IT, HR, Sales, Customer_Service`
- `My Lab > Lab Computers > Servers, Workstations`
- `My Lab > Groups > Security Groups`

### Security Groups
| Group | Purpose |
|---|---|
| SG_IT | IT department users |
| SG_HR | HR department users |
| SG_Sales | Sales department users |
| SG_Customer_Service | Customer Service users |
| SG_Admins | Administrative accounts |
| SG_ServiceAccounts | Service accounts |

### User Accounts
- Username format: first initial + last name (e.g. `jestepan`)
- UPN format: `firstname.lastname@joanlab.local`
- Department, Title, and Office fields populated
- Bulk created via PowerShell GUI tool using CSV input

## Key Concepts
- **OUs** organize objects in AD and are the target for GPO application
- **Security Groups** control access to resources like file shares and are used for item-level targeting in GPOs
- **UPN** is the user's login name in `user@domain` format, mirroring how M365 logins work in hybrid environments

## Screenshots
- `AD_OU_Structure.png`
- `AD_IT_OU_Users.png`
- `AD_Security_Groups.png`
- `AD_User_Properties.png`
- `AD_User_General.png`
