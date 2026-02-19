Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================
# CONFIG
# ==============================

$RepoJson = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/Config/scripts.json"
$LocalVersionFile = "$env:ProgramData\RMPIT_ScriptVersions.json"
$LogFile = "$env:ProgramData\RMPIT_Launcher.log"

# ==============================
# LOGGING
# ==============================

function Write-Log {
    param($Message)
    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogFile -Value "[$time] $Message"
}

# ==============================
# LOAD SCRIPT LIST
# ==============================

function Load-Scripts {
    try {
        $scripts = Invoke-RestMethod -Uri $RepoJson -UseBasicParsing
        Write-Log "Script list loaded successfully"
        return $scripts
    }
    catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to load script list from GitHub.","Error")
        Write-Log "ERROR: Failed to load script list"
        return $null
    }
}

# ==============================
# VERSION HANDLING
# ==============================

function Get-LocalVersions {
    if (Test-Path $LocalVersionFile) {
        return Get-Content $LocalVersionFile | ConvertFrom-Json
    }
    else {
        return @{}
    }
}

function Save-LocalVersions($versions) {
    $versions | ConvertTo-Json | Set-Content $LocalVersionFile
}

# ==============================
# RUN SCRIPT
# ==============================

function Run-Script($script) {

    $statusLabel.Text = "Running: $($script.Name)"
    Write-Log "Running script: $($script.Name)"

    $localVersions = Get-LocalVersions
    $needsRun = $true

    if ($localVersions.$($script.Name) -eq $script.Version) {
        $result = [System.Windows.Forms.MessageBox]::Show(
            "$($script.Name) version $($script.Version) already ran. Run again?",
            "Version Check",
            [System.Windows.Forms.MessageBoxButtons]::YesNo
        )
        if ($result -eq "No") { return }
    }

    try {
        Invoke-Expression (Invoke-RestMethod $script.Url -UseBasicParsing)
        $localVersions.$($script.Name) = $script.Version
        Save-LocalVersions $localVersions
        Write-Log "Completed: $($script.Name)"
        $statusLabel.Text = "Completed: $($script.Name)"
    }
    catch {
        Write-Log "ERROR running $($script.Name)"
        $statusLabel.Text = "Error running: $($script.Name)"
    }
}

# ==============================
# BUILD UI
# ==============================

$form = New-Object System.Windows.Forms.Form
$form.Text = "RMPIT Tech Toolkit - Professional Edition"
$form.Size = New-Object System.Drawing.Size(750,500)
$form.StartPosition = "CenterScreen"

$listBox = New-Object System.Windows.Forms.ListView
$listBox.View = "Details"
$listBox.FullRowSelect = $true
$listBox.GridLines = $true
$listBox.Size = New-Object System.Drawing.Size(700,350)
$listBox.Location = New-Object System.Drawing.Point(20,20)
$listBox.Columns.Add("Script Name",250)
$listBox.Columns.Add("Description",300)
$listBox.Columns.Add("Version",80)

$form.Controls.Add($listBox)

# Buttons
$runButton = New-Object System.Windows.Forms.Button
$runButton.Text = "Run Selected"
$runButton.Size = New-Object System.Drawing.Size(120,35)
$runButton.Location = New-Object System.Drawing.Point(20,390)

$runAllButton = New-Object System.Windows.Forms.Button
$runAllButton.Text = "Run All"
$runAllButton.Size = New-Object System.Drawing.Size(120,35)
$runAllButton.Location = New-Object System.Drawing.Point(160,390)

$form.Controls.Add($runButton)
$form.Controls.Add($runAllButton)

# Status bar
$statusBar = New-Object System.Windows.Forms.StatusStrip
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Ready"
$statusBar.Items.Add($statusLabel)
$form.Controls.Add($statusBar)

# ==============================
# LOAD DATA INTO UI
# ==============================

$scripts = Load-Scripts

if ($scripts) {
    foreach ($script in $scripts) {
        $item = New-Object System.Windows.Forms.ListViewItem($script.Name)
        $item.SubItems.Add($script.Description)
        $item.SubItems.Add($script.Version)
        $item.Tag = $script
        $listBox.Items.Add($item)
    }
}

# ==============================
# EVENTS
# ==============================

$runButton.Add_Click({
    if ($listBox.SelectedItems.Count -gt 0) {
        Run-Script $listBox.SelectedItems[0].Tag
    }
})

$runAllButton.Add_Click({
    foreach ($item in $listBox.Items) {
        Run-Script $item.Tag
    }
})

$listBox.Add_DoubleClick({
    if ($listBox.SelectedItems.Count -gt 0) {
        Run-Script $listBox.SelectedItems[0].Tag
    }
})

# ==============================
# SHOW FORM
# ==============================

Write-Log "Launcher Started"
$form.ShowDialog()
