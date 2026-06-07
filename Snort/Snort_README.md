# Snort IDS/IPS

## Overview
Installed and configured Snort 2.9.20 on pfSense in inline IPS mode to detect and block malicious traffic on the LAB interface.

## Environment
- **Snort Version:** 2.9.20
- **Mode:** Inline IPS
- **Interface:** LAB
- **Rules:** Emerging Threats (ET) + VRT community rules

## Configuration
- Snort running in inline mode — actively blocks matched traffic, not just alerts
- ET Open rules and VRT community rules downloaded and enabled
- Alerts confirmed via port scan test against LAB interface
- Running on LAB interface to monitor internal lab traffic

## Testing
- Ran port scan to generate alerts
- Verified alerts appeared in Snort Alerts page
- Confirmed rules are active and matching traffic

## Key Concepts
- **IDS vs IPS** — IDS (Intrusion Detection System) only alerts. IPS (Intrusion Prevention System) alerts AND blocks. Snort in inline mode = IPS
- **Rules** define what traffic patterns to look for — ET rules cover known malware, exploits, and suspicious behavior patterns
- **Inline mode** means traffic physically passes through Snort before reaching the destination — if a rule matches, Snort drops the packet before it arrives
- **LAB interface** placement monitors east-west traffic (between lab VMs) rather than just perimeter traffic

## Screenshots
- `Snort_Interface.png`
- `Snort_Alerts.png`
- `Snort_Rules.png`
