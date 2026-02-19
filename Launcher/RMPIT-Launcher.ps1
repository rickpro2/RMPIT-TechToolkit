Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================
# CONFIG
# ==============================

$RepoBase = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main"
$ScriptJsonUrl = "$RepoBase/scripts.json"
$LauncherVersionUrl = "$RepoBase/Launcher/launcher.version"
$LocalLauncherVersion = "3.0.0"
$VersionFile = "$env:ProgramData\RMPIT_ScriptVersions.json"
$LogFile = "$env:ProgramData\RMPIT_Launcher.log"

# ==============================
# LOGGING
# ==============================

function Write-Log {
    param($msg)
    Add-Content $LogFile "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $msg"
}

# ==============================
# ADMIN CHECK
# ==============================

function Is-Admin {
    $current = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $current.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# ==============================
# AUTO UPDATE
# ==============================

function Check-LauncherUpdate {
    try {
        $remoteVersion = Invoke-RestMethod $LauncherVersionUrl -UseBasicParsing
        if ($remoteVersion -ne $LocalLauncherVersion) {
            $result = [System.Windows.Forms.MessageBox]::Show(
                "New launcher version available ($remoteVersion). Update now?",
                "Update Available",
                "YesNo"
            )
            if ($result -eq "Yes") {
                iex (irm "$RepoBase/Launcher/RMPIT-Launcher.ps1")
                exit
            }
        }
    } catch {
        Write-Log "Launcher update check failed"
    }
}

# ==============================
# SCRIPT SIGNATURE CHECK
# ==============================

function Validate-Signature($url) {
    $temp = "$env:TEMP\temp_script.ps1"
    Invoke-WebRequest $url -OutFile $temp -UseBasicParsing
    $sig = Get-AuthenticodeSignature $temp
    if ($sig.Status -eq "Valid") {
        return $true
    }
    return $false
}

# ==============================
# LOAD SCRIPTS
# ==============================

function Load-Scripts {
    try {
        return Invoke-RestMethod $ScriptJsonUrl -UseBasicParsing
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to load script list.")
        return $null
    }
}

# ==============================
# RUN SCRIPT
# ==============================

function Run-Script($script) {

    if ($script.RequiresAdmin -and -not (Is-Admin)) {
        [System.Windows.Forms.MessageBox]::Show("This script requires Administrator privileges.")
        return
    }

    $progressBar.Value = 10
    $statusLabel.Text = "Validating signature..."

    if (-not (Validate-Signature $script.Url)) {
        [System.Windows.Forms.MessageBox]::Show("Script signature invalid.")
        return
    }

    $progressBar.Value = 40
    $statusLabel.Text = "Downloading..."

    $code = Invoke-RestMethod $script.Url -UseBasicParsing

    $progressBar.Value = 70
    $statusLabel.Text = "Executing..."

    try {
        Invoke-Expression $code
        $progressBar.Value = 100
        $statusLabel.Text = "Completed: $($script.Name)"
        Write-Log "Completed $($script.Name)"
    }
    catch {
        Write-Log "Error running $($script.Name)"
        $statusLabel.Text = "Error"
    }

    Start-Sleep 1
    $progressBar.Value = 0
}

# ==============================
# UI BUILD (Dark Mode)
# ==============================

$form = New-Object System.Windows.Forms.Form
$form.Text = "RMPIT Tech Toolkit - Enterprise v3"
$form.Size = New-Object System.Drawing.Size(850,600)
$form.BackColor = "#1e1e1e"
$form.ForeColor = "White"
$form.StartPosition = "CenterScreen"

$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(800,450)
$tabControl.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($tabControl)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Size = New-Object System.Drawing.Size(600,25)
$progressBar.Location = New-Object System.Drawing.Point(20,500)
$form.Controls.Add($progressBar)

$statusBar = New-Object System.Windows.Forms.StatusStrip
$statusBar.BackColor = "#2d2d2d"
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Ready"
$statusLabel.ForeColor = "White"
$statusBar.Items.Add($statusLabel)
$form.Controls.Add($statusBar)

# ==============================
# LOAD & GROUP SCRIPTS
# ==============================

Check-LauncherUpdate
$scripts = Load-Scripts

if ($scripts) {
    $categories = $scripts | Group-Object Category

    foreach ($cat in $categories) {

        $tab = New-Object System.Windows.Forms.TabPage
        $tab.Text = $cat.Name
        $tab.BackColor = "#1e1e1e"

        $list = New-Object System.Windows.Forms.ListView
        $list.View = "Details"
        $list.FullRowSelect = $true
        $list.GridLines = $true
        $list.BackColor = "#2d2d2d"
        $list.ForeColor = "White"
        $list.Size = New-Object System.Drawing.Size(750,350)
        $list.Location = New-Object System.Drawing.Point(10,10)
        $list.Columns.Add("Script",250)
        $list.Columns.Add("Description",350)
        $list.Columns.Add("Version",80)

        foreach ($script in $cat.Group) {
            $item = New-Object System.Windows.Forms.ListViewItem($script.Name)
            $item.SubItems.Add($script.Description)
            $item.SubItems.Add($script.Version)
            $item.Tag = $script
            $list.Items.Add($item)
        }

        $list.Add_DoubleClick({
            if ($list.SelectedItems.Count -gt 0) {
                Run-Script $list.SelectedItems[0].Tag
            }
        })

        $tab.Controls.Add($list)
        $tabControl.TabPages.Add($tab)
    }
}

Write-Log "Launcher started"
$form.ShowDialog()
