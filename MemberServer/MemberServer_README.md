# Member Server

## Overview
Configured a second Windows Server 2025 VM as a member server domain joined to `joanlab.local`, running IIS and acting as a secondary file server.

## Environment
- **Hostname:** `MEMBERSERVER01`
- **IP:** `192.168.100.51` (static)
- **Domain:** `joanlab.local`
- **OS:** Windows Server 2025

## Roles Installed
- **IIS (Web Server)** — serves internal lab portal page
- **Print Services** — configured for lab environment

## IIS Configuration
- Custom `index.html` deployed to `C:\inetpub\wwwroot\`
- Site binding: `http | * | 80`
- Page displays lab info, server stats, and fake-but-funny status logs
- Local GIF served from wwwroot (no external dependencies)

## Key Concepts
- **Member server** is any server joined to a domain that is not a DC — it receives GPOs, uses domain authentication, and appears in ADUC under the Servers OU
- **IIS bindings** tell IIS what protocol, IP, and port to listen on — `*` on port 80 means it responds to any IP hitting that machine on HTTP
- **Static IP** is assigned outside the DHCP range (192.168.100.51) so the server is always reachable at the same address

## Screenshots
- `MemberServer_ADUC.png`
- `MemberServer_IIS.png`
- `MemberServer_IIS_Console.png`
- `MemberServer_IIS_Bindings.png`
- `MemberServer_ComputerProperties.png`
- `MemberServer_PSRemote.png`
