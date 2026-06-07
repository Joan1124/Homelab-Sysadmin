# pfSense Firewall

## Overview
Deployed pfSense CE as a virtual firewall on Hyper-V to segment the lab network and enforce traffic rules between interfaces.

## Environment
- **pfSense Version:** CE 2.8.1
- **WAN Interface:** External Switch — `192.168.4.124` (home network NAT)
- **LAN Interface:** Internal Switch — `192.168.200.1`
- **LAB Subnet:** `192.168.200.0/24`

## Interface Configuration
| Interface | Switch | IP | Purpose |
|---|---|---|---|
| WAN | External | 192.168.4.124 | Uplink to home network |
| LAN | Internal | 192.168.200.1 | Lab network gateway |

## Firewall Rules

### WAN Rules
- OpenVPN allow rule: UDP port 1194 inbound to WAN address
- Block private networks: **Disabled** (WAN is behind home NAT — private IP on WAN is expected)

### LAN Rules
- Block Telnet: destination port 23, block action, logging enabled
- Default allow LAN rule: permits all other outbound traffic

## Key Concepts
- **WAN** faces the external/upstream network. In production this would be a public IP from your ISP. In this lab it's the home router subnet
- **LAN** is the internal network pfSense protects and routes for
- **Firewall rules are processed top to bottom** — the Block Telnet rule sits above the default allow so it catches port 23 traffic before the allow rule does
- **Block private networks** is a WAN setting that drops traffic sourced from RFC1918 addresses. Disabled here because the WAN itself is RFC1918

## Screenshots
- `pfSense_Dashboard.png`
- `pfSense_Interfaces.png`
- `pfSense_WAN_Rules.png`
- `pfSense_LAN_Rules.png`
- `pfSense_Telnet_Rule.png`
- `Firewall_Test_Results.png`
- `pfSense_Logs_Telnet.png`
- `pfSense_Logs_Overview.png`
