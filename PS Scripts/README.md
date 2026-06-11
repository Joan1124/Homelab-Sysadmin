# AD Scripts

PowerShell scripts for querying Active Directory and working with CSV user reports.

---

## Scripts

### `Export-ADGroupUsersFromCSV.ps1`
GUI tool. Pick a CSV file and browse for an AD group — exports every user from the CSV that is a member of that group to a new CSV on the desktop.

**Requirements:**
- RSAT (ActiveDirectory module)
- [ImportExcel](https://github.com/dfinke/ImportExcel) module (`Install-Module ImportExcel -Scope CurrentUser`)

**Usage:**
Run the script and use the GUI to select your CSV file and AD group. Results are saved to the desktop as `ADGroup_Matches_<timestamp>.csv`.

---

### `Export-ADGroupUsers-CLI.ps1`
CLI version of the above. Same logic, no GUI — just two prompts and it runs. Good for quick lookups or running on a server without a desktop session.

**Requirements:**
- RSAT (ActiveDirectory module)

**Usage:**
```powershell
.\Export-ADGroupUsers-CLI.ps1

CSV file path: C:\Users\you\Desktop\YourFile.csv
AD group name: SG_TestGroup

Results are saved to the desktop as `ADGroup_Matches_<timestamp>.csv` with the following columns:

| Column   | Description                        |
|----------|------------------------------------|
| Email    | Email from the CSV                 |
| UPN      | User Principal Name from AD        |
| Username | SAMAccountName                     |
| Active   | Whether the account is enabled     |

---

## Notes
- Both scripts match users by email address against the UPN in AD.
- Neither script makes any changes to AD — read only.
- The CSV must have an `Email` column header. If yours is named differently, update the `$email = $row.Email` and `Get-Member -Name "Email"` references in the script.
