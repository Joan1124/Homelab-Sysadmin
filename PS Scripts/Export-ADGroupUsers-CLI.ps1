
# Export-ADGroupUsers-CLI.ps1
# Reads a CSV, matches emails against AD group UPNs,
# checks if user is active, exports results to Desktop

Import-Module ActiveDirectory

#Input
$filePath  = Read-Host "CSV file path"
$groupName = Read-Host "AD group name"

if (-not (Test-Path $filePath)) {
    Write-Host "File not found: $filePath" -ForegroundColor Red
    exit 1
}

#Load CSV
$users = Import-Csv -Path $filePath

if (-not ($users | Get-Member -Name "Email")) {
    Write-Host "No 'Email' column found in CSV." -ForegroundColor Red
    exit 1
}

#Pull AD Group Members
Write-Host "Pulling members of '$groupName'..." -ForegroundColor Cyan

try {
    $adUsers = Get-ADGroupMember -Identity $groupName -Recursive |
               Get-ADUser -Properties UserPrincipalName, Enabled
} catch {
    Write-Host "Could not find group '$groupName'. Check the name and try again." -ForegroundColor Red
    exit 1
}

# Key by UPN for fast lookup
$adLookup = @{}
foreach ($u in $adUsers) {
    if ($u.UserPrincipalName) {
        $adLookup[$u.UserPrincipalName.ToLower().Trim()] = $u
    }
}

# Match
Write-Host "Matching against $($users.Count) CSV rows..." -ForegroundColor Cyan

$results = foreach ($row in $users) {
    $email = $row.Email
    if (-not $email) { continue }

    $adUser = $adLookup[$email.ToLower().Trim()]
    if ($adUser) {
        [PSCustomObject]@{
            Email      = $email
            UPN        = $adUser.UserPrincipalName
            Username   = $adUser.SamAccountName
            Active     = $adUser.Enabled
        }
    }
}

if (-not $results) {
    Write-Host "No matches found." -ForegroundColor Yellow
    exit 0
}

# Export
$outputPath = "$env:USERPROFILE\Desktop\ADGroup_Matches_$(Get-Date -Format 'yyyy-MM-dd_HHmm').csv"
$results | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

Write-Host "Matched $($results.Count) user(s). Saved to: $outputPath" -ForegroundColor Green
