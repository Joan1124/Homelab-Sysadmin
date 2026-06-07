# Group Policy Objects (GPOs)

## Overview
Configured four GPOs linked to the appropriate OUs to enforce security settings, drive mappings, and desktop policies across the domain.

## Environment
- **Domain:** `joanlab.local`
- **DC:** `WIN-89H2KGSP59Q`

## GPOs Configured

### GPO_ScreenLock_Users
- Screen saver timeout enforced
- Password required on resume
- Corporate wallpaper applied and locked
- **Linked to:** Lab Users OU

### GPO_MappedDrives
- Maps U: drive to department DFS share
- Uses item-level targeting scoped to each department security group
- Four entries — one per department (IT, HR, Sales, Customer_Service)
- Action set to `Update` to avoid conflicts
- **Linked to:** Lab Users OU

### GPO_BlockUSB
- All Removable Storage classes: Deny all access — Enabled
- Prevents data exfiltration via USB devices
- **Linked to:** Lab Users OU

### Default Domain Policy (Password Policy)
- Minimum password length: 12 characters
- Complexity enabled
- Maximum password age: 90 days

## Key Concepts
- **GPOs** are policy containers linked to OUs — every user or computer in that OU gets the policy applied at login or startup
- **Item-level targeting** on drive maps lets one GPO serve all departments — each entry only applies to users who are members of the matching security group
- **NTFS + GPO** work together: the GPO maps the drive, NTFS controls what they can do once they're in
- **USB blocking** via GPO is a common data loss prevention (DLP) control in HIPAA and compliance environments

## Screenshots
- `GPO_Overview.png`
- `GPO_ScreenLock_Settings.png`
- `GPO_MappedDrives.png`
- `GPO_MappedDrives_Targeting.png`
- `GPO_BlockUSB.png`
- `GPO_PasswordPolicy.png`
- `Win11_Wallpaper.png`
- `Win11_UDrive.png`
