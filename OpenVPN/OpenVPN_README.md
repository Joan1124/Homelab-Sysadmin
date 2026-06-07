# OpenVPN

## Overview
Configured an OpenVPN server on pfSense to allow secure remote access into the lab network from external devices.

## Environment
- **VPN Server:** pfSense at `192.168.200.1`
- **Tunnel Network:** `10.0.8.0/24`
- **Local Networks:** `192.168.100.0/24`, `192.168.200.0/24`
- **Protocol:** UDP port 1194
- **WAN IP:** `192.168.4.124`

## Configuration
- **CA:** JoanLab-CA
- **Server Certificate:** JoanLab-VPN-Server
- **VPN User:** `vpnuser`
- Block private networks disabled on WAN (required because WAN is behind home NAT, not public internet)

## Testing
- Connected from laptop via OpenVPN TAP adapter
- Assigned tunnel IP: `10.0.8.2`
- Successfully pinged DC at `192.168.100.1` confirming full tunnel access

## Key Concepts
- **OpenVPN** creates an encrypted tunnel between the client and server — all traffic through the tunnel is protected regardless of the underlying network
- **TUN vs TAP** — TAP (used here) operates at Layer 2, meaning the VPN client gets a virtual network adapter and behaves as if physically on the network
- **Block private networks** on WAN is disabled because the WAN interface is itself a private IP (`192.168.4.x`) — enabling it would block the VPN from working since all traffic would appear to come from a private range
- **PKI (Public Key Infrastructure)** — the CA, server cert, and client cert establish mutual trust between VPN server and client

## Screenshots
- `OpenVPN_Server.png`
- `OpenVPN_Connected.png`
