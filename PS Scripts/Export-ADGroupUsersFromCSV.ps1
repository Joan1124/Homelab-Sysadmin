# ============================================================
# Export-ADGroupUsersFromCSV.ps1
# Pick a CSV, browse for an AD group, export matches to Desktop
# Email column is hardcoded — no config needed
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.DirectoryServices
Add-Type -AssemblyName System.DirectoryServices.AccountManagement
Add-Type -AssemblyName Microsoft.VisualBasic

# ── AD Module Check ──────────────────────────────────────────
if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    [System.Windows.Forms.MessageBox]::Show(
        "ActiveDirectory module not found.`nMake sure RSAT is installed before running this.",
        "Missing Module",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Error
    )
    exit 1
}
Import-Module ActiveDirectory

$EmailColumn = "Email"

# ── Form ─────────────────────────────────────────────────────
$form                  = New-Object System.Windows.Forms.Form
$form.Text             = "AD Group CSV Export"
$form.Size             = New-Object System.Drawing.Size(460, 340)
$form.StartPosition    = "CenterScreen"
$form.FormBorderStyle  = "FixedDialog"
$form.MaximizeBox      = $false

# ── CSV File Row ─────────────────────────────────────────────
$lblFile          = New-Object System.Windows.Forms.Label
$lblFile.Text     = "CSV File:"
$lblFile.Location = New-Object System.Drawing.Point(20, 24)
$lblFile.Size     = New-Object System.Drawing.Size(70, 20)

$txtFile          = New-Object System.Windows.Forms.TextBox
$txtFile.Location = New-Object System.Drawing.Point(95, 21)
$txtFile.Size     = New-Object System.Drawing.Size(240, 22)
$txtFile.ReadOnly = $true

$btnBrowseFile          = New-Object System.Windows.Forms.Button
$btnBrowseFile.Text     = "Browse..."
$btnBrowseFile.Location = New-Object System.Drawing.Point(345, 19)
$btnBrowseFile.Size     = New-Object System.Drawing.Size(80, 26)

# ── AD Group Row ─────────────────────────────────────────────
$lblGroup          = New-Object System.Windows.Forms.Label
$lblGroup.Text     = "AD Group:"
$lblGroup.Location = New-Object System.Drawing.Point(20, 68)
$lblGroup.Size     = New-Object System.Drawing.Size(70, 20)

$txtGroup          = New-Object System.Windows.Forms.TextBox
$txtGroup.Location = New-Object System.Drawing.Point(95, 65)
$txtGroup.Size     = New-Object System.Drawing.Size(240, 22)
$txtGroup.ReadOnly = $true

$btnBrowseGroup          = New-Object System.Windows.Forms.Button
$btnBrowseGroup.Text     = "Browse..."
$btnBrowseGroup.Location = New-Object System.Drawing.Point(345, 63)
$btnBrowseGroup.Size     = New-Object System.Drawing.Size(80, 26)

# ── Run Button ───────────────────────────────────────────────
$btnRun          = New-Object System.Windows.Forms.Button
$btnRun.Text     = "Export Matches"
$btnRun.Location = New-Object System.Drawing.Point(20, 108)
$btnRun.Size     = New-Object System.Drawing.Size(405, 30)
$btnRun.Enabled  = $false

# ── Log Box ──────────────────────────────────────────────────
$lblLog          = New-Object System.Windows.Forms.Label
$lblLog.Text     = "Log:"
$lblLog.Location = New-Object System.Drawing.Point(20, 152)
$lblLog.Size     = New-Object System.Drawing.Size(40, 20)

$txtLog                    = New-Object System.Windows.Forms.TextBox
$txtLog.Location           = New-Object System.Drawing.Point(20, 172)
$txtLog.Size               = New-Object System.Drawing.Size(405, 118)
$txtLog.Multiline          = $true
$txtLog.ReadOnly           = $true
$txtLog.ScrollBars         = "Vertical"
$txtLog.Font               = New-Object System.Drawing.Font("Consolas", 8.5)
$txtLog.BackColor          = [System.Drawing.Color]::White

# ── Wire up form ─────────────────────────────────────────────
$form.Controls.AddRange(@(
    $lblFile, $txtFile, $btnBrowseFile,
    $lblGroup, $txtGroup, $btnBrowseGroup,
    $btnRun, $lblLog, $txtLog
))

# ── Helpers ──────────────────────────────────────────────────
function Write-Log {
    param([string]$msg, [string]$level = "INFO")
    $ts = Get-Date -Format "HH:mm:ss"
    $txtLog.AppendText("[$ts] [$level] $msg`r`n")
    $txtLog.ScrollToCaret()
}

function Update-RunButton {
    $btnRun.Enabled = ($txtFile.Tag -and $txtGroup.Tag)
}

# ── Browse CSV ───────────────────────────────────────────────
$btnBrowseFile.Add_Click({
    $dlg        = New-Object System.Windows.Forms.OpenFileDialog
    $dlg.Filter = "CSV Files (*.csv)|*.csv"
    $dlg.Title  = "Select your CSV file"
    if ($dlg.ShowDialog() -eq "OK") {
        $txtFile.Text = $dlg.FileName
        $txtFile.Tag  = $dlg.FileName
        Write-Log "File selected: $($dlg.FileName)"
        Update-RunButton
    }
})

# ── Browse AD Group ──────────────────────────────────────────
$btnBrowseGroup.Add_Click({
    # Type part of the group name, get back a list to pick from
    $groupInput = [Microsoft.VisualBasic.Interaction]::InputBox(
        "Enter part of the AD group name to search:",
        "Find AD Group",
        ""
    )

    if ($groupInput.Trim() -eq "") { return }

    try {
        $results = Get-ADGroup -Filter "Name -like '*$groupInput*'" |
                   Select-Object -ExpandProperty Name | Sort-Object

        if (-not $results) {
            Write-Log "No groups found matching '$groupInput'." "WARN"
            return
        }

        # Show results in a picker listbox dialog
        $pickForm              = New-Object System.Windows.Forms.Form
        $pickForm.Text         = "Select AD Group"
        $pickForm.Size         = New-Object System.Drawing.Size(340, 300)
        $pickForm.StartPosition = "CenterParent"
        $pickForm.FormBorderStyle = "FixedDialog"
        $pickForm.MaximizeBox  = $false

        $listBox               = New-Object System.Windows.Forms.ListBox
        $listBox.Location      = New-Object System.Drawing.Point(10, 10)
        $listBox.Size          = New-Object System.Drawing.Size(300, 200)
        $listBox.Items.AddRange($results)

        $btnSelect             = New-Object System.Windows.Forms.Button
        $btnSelect.Text        = "Select"
        $btnSelect.Location    = New-Object System.Drawing.Point(10, 220)
        $btnSelect.Size        = New-Object System.Drawing.Size(300, 30)
        $btnSelect.DialogResult = "OK"
        $pickForm.AcceptButton = $btnSelect

        $pickForm.Controls.AddRange(@($listBox, $btnSelect))

        if ($pickForm.ShowDialog() -eq "OK" -and $listBox.SelectedItem) {
            $selected         = $listBox.SelectedItem.ToString()
            $txtGroup.Text    = $selected
            $txtGroup.Tag     = $selected
            Write-Log "Group selected: $selected"
            Update-RunButton
        }

    } catch {
        Write-Log "Error searching AD: $_" "ERROR"
    }
})

# ── Export ───────────────────────────────────────────────────
$btnRun.Add_Click({
    $btnRun.Enabled = $false
    $txtLog.Clear()

    $filePath   = $txtFile.Tag
    $groupName  = $txtGroup.Tag
    $outputPath = "$env:USERPROFILE\Desktop\ADGroup_Matches_$(Get-Date -Format 'yyyy-MM-dd_HHmm').csv"

    try {
        Write-Log "Reading CSV..."
        $users = Import-Csv -Path $filePath

        if ($users.Count -eq 0) {
            Write-Log "CSV is empty." "WARN"
            return
        }

        $cols = $users[0].PSObject.Properties.Name
        if ($EmailColumn -notin $cols) {
            Write-Log "No '$EmailColumn' column found. Columns in file: $($cols -join ', ')" "ERROR"
            return
        }

        Write-Log "Pulling members of: $groupName"
        $groupMembers = Get-ADGroupMember -Identity $groupName -Recursive |
                        Get-ADUser -Properties EmailAddress |
                        Where-Object { $_.EmailAddress } |
                        Select-Object -ExpandProperty EmailAddress |
                        ForEach-Object { $_.ToLower().Trim() }

        Write-Log "Found $($groupMembers.Count) member(s) in the group."

        Write-Log "Comparing against CSV ($($users.Count) rows)..."
        $matches = $users | Where-Object {
            $_.$EmailColumn -and $groupMembers -contains $_.$EmailColumn.ToLower().Trim()
        }

        if (-not $matches) {
            Write-Log "No matches. Nobody in the CSV is in '$groupName'." "WARN"
            return
        }

        Write-Log "Matched $($matches.Count) user(s). Exporting..."
        $matches | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

        Write-Log "Done. File saved to: $outputPath" "SUCCESS"

    } catch {
        Write-Log "Error: $_" "ERROR"
    } finally {
        Update-RunButton
    }
})

# ── Launch ───────────────────────────────────────────────────
[void]$form.ShowDialog()
