# Identity Protection & Privileged Identity Management (PIM)
**Phase 5 | MS-102 Lab | Joan Estepan**

## Overview
This phase covers risk-based identity protection controls and privileged access management. Identity Protection risk policies are implemented via Conditional Access (the native risk policy blade is deprecated in the current Entra portal). PIM is configured to enforce Just-In-Time (JIT) access for the Global Administrator role.

## Infrastructure
| Component | Details |
|---|---|
| License | Entra ID P2 (via M365 E5 trial) |
| Portal | entra.microsoft.com |
| PIM | Entra → Identity Governance → Privileged Identity Management |

## What Was Configured

### Identity Protection — Risk Policies (via Conditional Access)
> The native Identity Protection risk policy blade has been deprecated in the current Entra portal. Risk-based policies are now correctly configured through Conditional Access, which is the current Microsoft-recommended approach.

**User Risk Policy**
- Condition: User risk = **High**
- Grant: **Require password change**
- Scope: All users

**Sign-in Risk Policy**
- Condition: Sign-in risk = **Medium and above**
- Grant: **Require MFA**
- Scope: All users

### Privileged Identity Management (PIM)
- Converted Global Administrator from **permanent** to **Eligible** assignment
- Configured activation settings:
  - Require MFA on activation
  - Require justification
  - Maximum activation duration: 1 hour
- Activated the role as eligible user — completed full MFA + justification flow
- Configured **Access Review** for Global Admin role — monthly cadence
- PIM audit log captures every activation with timestamp, user, and justification

## Verification
- Sign-in logs confirm risk-based CA policies apply to flagged events
- PIM audit log shows activation event with full details
- Access review configured and active in Identity Governance

## Screenshots
| File | Description |
|---|---|
| `idp_user_risk_ca_policy.png` | CA Policy — User risk High → Require password change |
| `idp_signin_risk_ca_policy.png` | CA Policy — Sign-in risk Medium+ → Require MFA |
| `idp_risk_policies_overview.png` | CA policy list showing both risk policies enabled |
| `pim_global_admin_eligible_assignment.png` | PIM → Global Admin role → Eligible assignments tab |
| `pim_role_activation_flow.png` | PIM activation — MFA + justification flow |
| `pim_audit_log_activation.png` | PIM audit log showing activation with timestamp and justification |
| `pim_access_review_config.png` | Monthly access review configured for Global Admin role |

## Key Concepts Demonstrated
- Risk-based Conditional Access (user risk + sign-in risk)
- Current Entra portal deprecation of standalone risk policy blade
- Just-In-Time privileged access via PIM
- Principle of least privilege — no permanent Global Admin assignments
- PIM activation workflow (MFA + justification requirement)
- Access Reviews for ongoing privileged role governance
- PIM audit logging for compliance and forensic purposes
