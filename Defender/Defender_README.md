# Microsoft Defender — Endpoint, Office 365 & Cloud Apps
**Phase 6 | MS-102 Lab | Joan Estepan**

## Overview
This phase covers Microsoft Defender for Office 365 (MDO) and Microsoft Defender for Cloud Apps (MDCA). Defender for Endpoint (MDE) onboarding was not available due to licensing limitations in the E5 trial — documented below as a known constraint, not a configuration gap.

## Infrastructure
| Component | Details |
|---|---|
| Portal | security.microsoft.com |
| License | M365 E5 + O365 E5 trial |
| Tenant | jnj1124.com |

---

## Defender for Endpoint (MDE)
> **Licensing Note:** MDE device onboarding was unavailable in this E5 trial configuration. This is a known trial limitation and does not reflect a gap in knowledge or configuration ability. MDE onboarding, ASR rules, and EICAR test detection are covered in the MD-102 Intune lab at [github.com/Joan1124/Microsoft-Intune-Lab](https://github.com/Joan1124/Microsoft-Intune-Lab).

---

## Defender for Office 365 (MDO)

### Safe Links Policy
- Scans URLs in **email and Office apps**
- Applied to **all users**
- Blocks malicious URLs at time-of-click

### Safe Attachments Policy
- Mode: **Dynamic Delivery**
- Applied to **all domains**
- Delivers email immediately while scanning attachments in sandbox

### Anti-Phishing Policy — "My Lab Anti-Phishing Policy 1"
- **Mailbox Intelligence:** Enabled — detects impersonated users
- **Impersonation Protection:** User + Domain impersonation enabled
- **Spoof Intelligence:** Enabled
- **DMARC enforcement:** Quarantine on p=quarantine, Reject on p=reject
- **Safety tips:** First contact, user impersonation, domain impersonation, unusual characters — all On
- **Unauthenticated sender indicators:** (?) symbol and via tag — both On
- Priority: 0 | Status: On | Created: July 4, 2026

### Attack Simulator
- Ran simulated phishing campaign against lab users
- Reviewed campaign results and click-through rates
- Validates MDO detection and user awareness posture

---

## Defender for Cloud Apps (MDCA)

### Integration
- MDCA integrated with M365 tenant via unified Defender portal
- Microsoft 365 natively connected (standalone App Connectors UI deprecated in unified portal)

### Anomaly Detection Policies (21 active policies)
Built-in threat detection policies active including:
- **Impossible travel** — flags sign-ins from geographically impossible locations
- **Suspicious inbox forwarding** — detects auto-forward rules (common exfiltration vector)
- **Suspicious inbox manipulation rule** — detects malicious inbox rules
- **Ransomware activity** — behavioral detection for ransomware patterns
- **Activity performed by terminated user** — detects activity from disabled accounts

### Activity Policy
- Custom activity policy configured for anomaly detection
- Scoped to Microsoft 365 connected app

---

## Screenshots
| File | Description |
|---|---|
| `mdo_safe_links_policy.png` | Safe Links policy — URL scanning enabled for email + Office apps |
| `mdo_safe_attachments_policy.png` | Safe Attachments — Dynamic Delivery mode, all domains |
| `mdo_antiphishing_policy.png` | Anti-phishing policy — full settings including DMARC + safety tips |
| `mdo_attack_simulator_results.png` | Attack Simulator — completed phishing campaign results |
| `mdca_anomaly_detection_policies.png` | MDCA — 21 active anomaly detection policies including Impossible Travel |
| `mdca_activity_policy_detail.png` | MDCA — custom activity policy detail |
| `mdca_policies_overview.png` | MDCA — full policies overview list |

## Key Concepts Demonstrated
- Email security layers (Safe Links, Safe Attachments, Anti-phishing)
- DMARC policy enforcement via MDO
- Spoof intelligence and mailbox intelligence
- Simulated phishing for security awareness validation
- Cloud app behavioral threat detection (MDCA)
- Impossible travel and anomaly detection policies
- Understanding of portal unification and deprecated connector UI
