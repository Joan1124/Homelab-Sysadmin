# Microsoft Purview — Information Protection, DLP, eDiscovery & Audit
**Phases 7 & 8 | MS-102 Lab | Joan Estepan**

## Overview
This phase covers the full Microsoft Purview compliance stack — sensitivity labels, data loss prevention, retention policies, eDiscovery with legal hold, and audit log management. All configurations were built in the compliance.microsoft.com portal against the live M365 E5 trial tenant.

## Infrastructure
| Component | Details |
|---|---|
| Portal | compliance.microsoft.com |
| License | M365 E5 (Purview compliance features) |
| Tenant | jnj1124.com |
| SharePoint/Exchange | Active |

---

## Phase 7 — Information Protection & DLP

### Sensitivity Labels
Label hierarchy built in Purview → Information Protection:

| Label | Encryption | Content Marking | Notes |
|---|---|---|---|
| Public | No | No | Baseline label |
| Internal | No | No | Internal use only |
| My Confidential Label | Yes (Control Access) | Header stamp | Custom lab label |
| Confidential (MS default) | Yes | Yes | Left intact |
| Confidential \ HR Only | Yes | Yes | Sublabel |

- Label policy published with **mandatory labeling enforced** — users must label before sending
- Scoped to **All users**
- Manual labeling confirmed working in Word and Outlook
- Auto-labeling policy **"My lab financial data auto labels"** configured with conditions: SSN, EU SSN, Spain SSN, Credit Card, Bank Account, ABA Routing Number

> **Auto-label Note:** Simulation initially returned 0 matches. Root cause identified: **Unified Audit Log was disabled**. Fixed via:
> ```powershell
> Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
> ```
> Confirmed enabled via `Get-AdminAuditLogConfig`. Classification engine reindex in progress.

### Retention Policies
- **Policy:** `My_lab_retention_policy`
- **Scope:** Exchange email, SharePoint, OneDrive, M365 Groups
- **Settings:** Retain 7 years → delete after retention period
- **Status:** Active (up to 1 week propagation time)

### Data Loss Prevention (DLP)
- **Template:** Financial/PII
- **Conditions:** Credit Card, Bank Account, ABA Routing Number, SSN
- **Actions:**
  - Policy tips and email notification to user
  - Detect 1-2 instances
  - Incident reports generated
  - Alerts enabled
  - Restrict external sharing
  - Override allowed with business justification
- **Mode:** Simulation → promoted to enforcement after review
- Policy tips confirmed appearing in Outlook on test emails with fake credit card numbers

---

## Phase 8 — eDiscovery & Audit

### eDiscovery Standard Case
- **Case Name:** "My lab Case - departing employee investigation"
- **Search keyword:** SSN
- **Results:** 20 matches (11 mailbox items + 9 SharePoint site items)
- **Hold:** 2/2 locations on hold
  - Shorty Dog mailbox
  - SharePoint site
- **Export:** Full metadata manifest exported (Items, Locations, Settings, Summary CSVs)

**Hold verified via PowerShell:**
```powershell
Get-Mailbox -Identity shorty.dog@jnj1124.com | Select InPlaceHolds
# Returns: UniH GUID — confirms Unified Hold (not legacy litigation hold)
```

### Audit Logs
- Multiple audit searches completed
- Results: 13 / 96 / 13 events across separate searches
- Timestamped entries showing user, IP address, and action confirmed
- **Audit Retention Policy:** "1 Year Hold" — 1 year duration, Priority 1, all users and record types

---

## Screenshots
| File | Description |
|---|---|
| `purview_sensitivity_label_hierarchy.png` | Full label hierarchy in Purview portal |
| `purview_confidential_label_encryption.png` | Confidential label — encryption/Control Access settings |
| `purview_confidential_label_content_marking.png` | Confidential label — content marking / header stamp |
| `purview_label_policy_mandatory.png` | Label policy — mandatory labeling, All users scoped |
| `purview_label_applied_in_word.png` | Sensitivity label applied in Word — header/footer/watermark visible |
| `purview_autolabel_policy_conditions.png` | Auto-label policy conditions (SSN, Credit Card, etc.) |
| `purview_autolabel_simulation_results.png` | Auto-label simulation results |
| `purview_activity_explorer_label_events.png` | Activity Explorer showing label activity events |
| `purview_retention_policy_detail.png` | Retention policy — 7yr retain, scopes listed |
| `purview_retention_policy_list.png` | Retention policies list — policy showing Active |
| `purview_dlp_policy_list.png` | DLP policy list — policies with simulation/enforcement mode |
| `purview_dlp_policy_conditions.png` | DLP policy conditions — Credit Card, SSN, ABA Routing, Bank Account |
| `purview_dlp_alert_triggered.png` | DLP alerts page — alert triggered after SSN condition added |
| `purview_dlp_policy_tip_outlook.png` | Policy tip appearing in Outlook on test email with fake CC number |
| `purview_ediscovery_case_overview.png` | eDiscovery case overview — departing employee investigation |
| `purview_ediscovery_search_results.png` | Search results — 20 SSN keyword matches |
| `purview_ediscovery_hold_applied.png` | Hold detail — 2/2 locations on hold |
| `purview_ediscovery_hold_powershell.png` | PowerShell confirming UniH GUID on mailbox hold |
| `purview_audit_search_results.png` | Audit search results — timestamped events with user/IP/action |
| `purview_audit_retention_policy.png` | Audit retention policy — 1 Year Hold, priority 1 |

## Key Concepts Demonstrated
- Sensitivity label hierarchy design and publishing
- Mandatory labeling enforcement
- Auto-labeling policy configuration and troubleshooting (UAL dependency)
- Unified Audit Log enablement and validation via PowerShell
- Retention policy scoping across workloads
- DLP policy with multiple sensitive info types and layered actions
- Simulation mode vs enforcement mode in DLP
- eDiscovery case management — search, hold, export workflow
- Legal hold verification via PowerShell (Unified Hold vs Litigation Hold distinction)
- Audit log search and retention policy configuration
