# DNS Verification

## Overview
Verified that DNS is resolving correctly for the `joanlab.local` domain, confirming that the DC is authoritative and clients can resolve domain names.

## Environment
- **DNS Server:** `WIN-89H2KGSP59Q` — `192.168.100.1`
- **Domain:** `joanlab.local`

## Verification Performed
```powershell
nslookup joanlab.local
# Returns: 192.168.100.1

nslookup WIN-89H2KGSP59Q.joanlab.local
# Returns: 192.168.100.1
```

## Key Concepts
- **DNS** translates hostnames to IP addresses — critical for AD because domain join, GPO processing, Kerberos authentication, and DFS all rely on DNS working correctly
- **nslookup** queries the DNS server directly to verify resolution — if this fails, nothing in the domain works properly
- The DC runs its own DNS server and is authoritative for the `joanlab.local` zone — meaning it holds the records and answers queries for that domain

## Screenshots
- `DNS_nslookup.png`
