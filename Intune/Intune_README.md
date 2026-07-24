# Microsoft Intune — Endpoint Management
**Phase 4 | MS-102 Lab | Joan Estepan**

## Overview
This phase covers Microsoft Intune enrollment, compliance policy enforcement, and configuration profile deployment. LABVM1 is enrolled via automatic MDM enrollment and verified as compliant in the Intune portal.

> **Note:** A separate, more detailed Intune lab (MD-102 exam prep) is documented at [github.com/Joan1124/Microsoft-Intune-Lab](https://github.com/Joan1124/Microsoft-Intune-Lab) — includes Autopilot with ESP, LAPS, BitLocker, Windows Hello, Security Baseline, Update Rings, and Android App Protection Policy across a full 10-group tenant.

## Infrastructure
| Component | Details |
|---|---|
| MDM Authority | Microsoft Intune |
| Enrolled Device | LABVM1 (Windows 11, Hybrid Azure AD Joined) |
| Portal | intune.microsoft.com |
| License | M365 E5 (includes Intune P2) |

## What Was Configured

### MDM Authority
- Set MDM authority to **Microsoft Intune** in intune.microsoft.com
- Enabled automatic MDM enrollment: Entra → Mobility (MDM and MAM) → Microsoft Intune → All users

### Device Enrollment
- Enrolled LABVM1 via: Settings → Accounts → Access work or school → Connect with M365 account
- LABVM1 verified as **Compliant** in Intune → Devices → Windows

### Compliance Policy
- **Requirements:** BitLocker enabled + minimum OS version
- **Assignment:** All Devices
- LABVM1 passes all compliance checks

### Configuration Profile
- Pushed custom desktop wallpaper / Start menu layout to LABVM1
- Confirms profile delivery and device responsiveness to Intune policies

## Verification
```
Intune → Devices → Windows → LABVM1 → Status: Compliant ✅
```

## Screenshots
| File | Description |
|---|---|
| `intune_mdm_authority.png` | Tenant Administration showing MDM authority = Microsoft Intune |
| `intune_auto_enrollment_scope.png` | Entra Mobility settings — MDM scope set to All users |
| `intune_labvm1_compliant.png` | Intune Devices list — LABVM1 showing Compliant status |
| `intune_labvm1_device_detail.png` | LABVM1 device detail page — hardware info + compliance state |
| `intune_compliance_policy_settings.png` | Compliance policy — BitLocker + min OS version conditions |
| `intune_config_profile_detail.png` | Configuration profile detail — assignments visible |

## Key Concepts Demonstrated
- MDM authority configuration
- Automatic MDM enrollment via Entra integration
- Device compliance policy enforcement (BitLocker, OS version)
- Configuration profile deployment via Intune
- Hybrid Azure AD Joined device management
- Intune device lifecycle and compliance reporting
