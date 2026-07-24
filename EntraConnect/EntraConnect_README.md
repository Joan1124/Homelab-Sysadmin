# Entra Connect — Hybrid Identity
**Phase 4 | MS-102 Lab | Joan Estepan**

## Overview
This phase establishes hybrid identity between the on-premises Active Directory domain (`joanlab.local`) and Microsoft Entra ID (M365 tenant: `jnj1124.com`) using Microsoft Entra Connect Sync with Password Hash Sync (PHS) as the authentication method. Devices are automatically hybrid joined to Entra ID via Group Policy.

## Infrastructure
| Component | Details |
|---|---|
| On-prem Domain | joanlab.local |
| M365 Tenant | jnj1124.com |
| Entra Connect Server | MEMBERSERVER01 |
| Auth Method | Password Hash Sync (PHS) |
| Device Join Method | Hybrid Azure AD Join via GPO |
| Hypervisor | Hyper-V on Dell Precision 3620 |

## What Was Configured
- Installed and configured **Microsoft Entra Connect Sync** on MEMBERSERVER01
- Synced `joanlab.local` on-premises users to Entra ID
- Configured **Password Hash Sync** as the authentication method
- Verified on-prem AD users appear in Entra ID with source = Windows Server AD
- Configured **Hybrid Azure AD Join** via Group Policy (`Hybrid Entra Join` GPO)
  - Policy: `Register domain joined computers as devices` → Enabled
  - GPO linked to: `joanlab.local/My Lab/Lab Computers` OU
- Verified LABVM1 is hybrid joined via `dsregcmd /status`

## Verification
```powershell
# Run on LABVM1 to confirm hybrid join
dsregcmd /status
# Expected: AzureAdJoined: YES | DomainJoined: YES
```

## Screenshots
| File | Description |
|---|---|
| `entra_connect_synced_users.png` | Entra portal showing synced users with source = Windows Server AD |
| `entra_connect_sync_service_running.png` | Synchronization Service Manager — 726 successful sync runs |
| `entra_connect_hybrid_join_dsregcmd.png` | dsregcmd /status output on LABVM1 confirming hybrid join |
| `entra_connect_hybrid_join_device_portal.png` | Entra portal → Devices showing LABVM1 as Hybrid Azure AD Joined |
| `entra_connect_connectors.png` | Sync Manager Connectors tab — joanlab.local + JoanADlab.onmicrosoft.com |
| `entra_connect_hybrid_join_gpo.png` | Group Policy Management showing Hybrid Entra Join GPO config |

## Key Concepts Demonstrated
- Hybrid identity architecture (on-prem AD + cloud Entra ID)
- Password Hash Sync vs Pass-Through Authentication vs Federation
- Entra Connect Sync connector architecture
- Hybrid Azure AD Join via GPO at scale
- Device identity management across on-prem and cloud
