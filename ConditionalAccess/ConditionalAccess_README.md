# Conditional Access
**Phase 4 & 5 | MS-102 Lab | Joan Estepan**

## Overview
Conditional Access policies enforce Zero Trust access controls across the M365 tenant. This phase covers three core CA policies for MFA enforcement, legacy auth blocking, and device compliance requirements — plus risk-based CA policies replacing the deprecated Identity Protection risk policy blade.

## Infrastructure
| Component | Details |
|---|---|
| M365 Tenant | jnj1124.com |
| Entra ID License | P2 (via E5 trial) |
| Portal | entra.microsoft.com → Protection → Conditional Access |

## Policies Configured

### Policy 1 — Require MFA for All Users
- **Assignments:** All users, All cloud apps
- **Grant:** Require MFA
- **Mode:** Report-Only first → reviewed sign-in logs → enforced

### Policy 2 — Block Legacy Authentication
- **Condition:** Client apps = Exchange ActiveSync + Other clients
- **Grant:** Block access
- **Purpose:** Eliminate auth protocols that bypass MFA (IMAP, POP3, SMTP AUTH)

### Policy 3 — Require Compliant or Hybrid Joined Device
- **Grant:** Require device marked compliant OR Hybrid Azure AD joined
- **Exclusion:** Break-glass Global Admin excluded from ALL CA policies

### Policy 4 — User Risk (replaces deprecated Identity Protection risk policy)
- **Condition:** User risk = High
- **Grant:** Require password change
- **Note:** Native Identity Protection risk policy blade deprecated in Entra — implemented via CA instead

### Policy 5 — Sign-in Risk (replaces deprecated Identity Protection risk policy)
- **Condition:** Sign-in risk = Medium and above
- **Grant:** Require MFA
- **Note:** Same deprecation — CA policies are now the correct implementation path

## Verification
- Reviewed sign-in logs → Conditional Access tab on individual sign-in events confirms policies applied
- All risk-based policies confirmed active in CA policy list

## Screenshots
| File | Description |
|---|---|
| `ca_policies_overview.png` | Full CA policy list — all policies and their status |
| `ca_policy1_require_mfa.png` | Policy 1 detail — MFA for all users |
| `ca_policy2_block_legacy_auth.png` | Policy 2 detail — Block legacy auth with client apps condition |
| `ca_policy3_require_compliant_device.png` | Policy 3 detail — Compliant or Hybrid Joined device grant |
| `ca_sign_in_log_policies_applied.png` | Sign-in log event showing CA policies applied in results |
| `idp_user_risk_ca_policy.png` | CA Policy — User risk High → Require password change |
| `idp_signin_risk_ca_policy.png` | CA Policy — Sign-in risk Medium+ → Require MFA |
| `idp_risk_policies_overview.png` | CA policy list showing both risk-based policies enabled |

## Key Concepts Demonstrated
- Zero Trust access model via Conditional Access
- MFA enforcement at tenant level
- Legacy authentication blocking (critical for security posture)
- Device compliance as an access condition
- Risk-based access control (user risk + sign-in risk)
- Break-glass account exclusion best practice
- Report-Only mode for safe policy testing before enforcement
