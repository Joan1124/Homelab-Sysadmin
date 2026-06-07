# Veeam Backup

## Overview
Configured Veeam Agent for Windows Free on a dedicated desktop to back up the lab drive containing all VM files and lab data.

## Environment
- **Veeam Product:** Veeam Agent for Windows Free
- **Host:** Dell Precision Tower 3620 (i5-6500, 16GB RAM, 238GB SSD + 3.64TB HDD)
- **Backup Source:** D: drive (VM files and lab data)
- **Backup Destination:** E: partition (500GB carved from HDD)

## Why Veeam Agent Instead of B&R
Veeam Backup & Replication requires Windows Server as the host OS. The dedicated desktop runs Windows 10, so Veeam Agent for Windows Free was used instead — it provides the same core backup and file-level restore functionality for workstation/desktop hosts.

## Backup Job
- Full backup of D: drive completed successfully
- **Size:** 112GB
- **Duration:** 1:04:06
- **Method:** VSS snapshot (consistent backup while system is running)
- **Status:** All green

## File Level Restore
- Tested file-level restore via Backup Browser
- Navigated D: drive structure inside the backup
- Restored file to `C:\VeeamFLR\` (safe temp location, no production data affected)

## Key Concepts
- **VSS (Volume Shadow Copy Service)** creates a point-in-time snapshot of the volume so Veeam can back up files that are open or in use without interruption
- **File-level restore** lets you browse inside a backup like a file explorer and pull out individual files — no need to restore the entire volume
- **Full backup vs incremental** — full captures everything every time. Incremental only captures changes since the last backup (faster, less storage). Veeam Agent Free supports both
- **3-2-1 rule** — 3 copies of data, 2 different media types, 1 offsite. This lab covers local backup; offsite would be the next step

## Screenshots
- `Veeam_Dashboard.png`
- `Veeam_BackupJob.png`
- `Veeam_BackupComplete.png`
- `Veeam_FileRestore.png`
