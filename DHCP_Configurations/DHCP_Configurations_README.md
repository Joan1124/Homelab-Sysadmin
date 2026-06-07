# DHCP Configuration

## Overview
Configured a DHCP scope on the domain controller to automatically assign IP addresses to lab machines on the `192.168.100.0/24` subnet.

## Environment
- **DHCP Server:** `WIN-89H2KGSP59Q`
- **Subnet:** `192.168.100.0/24`

## Scope Configuration
| Setting | Value |
|---|---|
| Scope Name | JoanLab Scope |
| Range | 192.168.100.50 — 192.168.100.200 |
| Exclusions | 192.168.100.1 — 192.168.100.49 |
| Router (Gateway) | 192.168.100.1 |
| DNS Server | 192.168.100.1 |
| Domain Name | joanlab.local |

## Key Concepts
- **DHCP** automates IP assignment so machines don't need static IPs configured manually
- **Exclusion range** reserves IPs for static assignment — servers, printers, network devices that need consistent addresses
- **Scope options** like router and DNS are pushed to clients along with the IP so they know how to reach the network and resolve names
- Static IPs (DC at .1, Member Server at .51) are outside the DHCP range to prevent conflicts

## Screenshots
- `DHCP_Scope.png`
- `DHCP_Options.png`
- `DHCP_Exclusions.png`
