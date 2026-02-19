# ==============================
# FORCE ADMIN ELEVATION
# ==============================

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    Write-Host "Restarting as Administrator..."
    
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/Launcher/RMPIT-Launcher.ps1 | iex`""
    $psi.Verb = "runas"

    try {
        [System.Diagnostics.Process]::Start($psi) | Out-Null
    }
    catch {
        Write-Host "User declined elevation."
    }

    exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================
# CONFIG
# ==============================

$RepoBase = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main"
$ScriptJsonUrl = "$RepoBase/scripts.json"
$LauncherVersionUrl = "$RepoBase/Launcher/launcher.version"
$LocalLauncherVersion = "3.1.0"
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

    $progressBar.Value = 20
    $statusLabel.Text = "Downloading $($script.Name)..."

    try {
        $code = Invoke-RestMethod $script.Url -UseBasicParsing

        $progressBar.Value = 60
        $statusLabel.Text = "Executing..."

        Invoke-Expression $code

        $progressBar.Value = 100
        $statusLabel.Text = "Completed: $($script.Name)"
        Write-Log "Completed $($script.Name)"
    }
    catch {
        $statusLabel.Text = "Error running script"
        Write-Log "Error running $($script.Name)"
    }

    Start-Sleep 1
    $progressBar.Value = 0
}

# ==============================
# THEME FUNCTION
# ==============================

function Apply-Theme($mode) {

    if ($mode -eq "Dark") {
        $form.BackColor = "#1e1e1e"
        $form.ForeColor = "White"
        $statusBar.BackColor = "#2d2d2d"
        $statusLabel.ForeColor = "White"
        foreach ($tab in $tabControl.TabPages) {
            $tab.BackColor = "#1e1e1e"
            foreach ($ctrl in $tab.Controls) {
                if ($ctrl -is [System.Windows.Forms.ListView]) {
                    $ctrl.BackColor = "#2d2d2d"
                    $ctrl.ForeColor = "White"
                }
            }
        }
    }
    else {
        $form.BackColor = "White"
        $form.ForeColor = "Black"
        $statusBar.BackColor = "LightGray"
        $statusLabel.ForeColor = "Black"
        foreach ($tab in $tabControl.TabPages) {
            $tab.BackColor = "White"
            foreach ($ctrl in $tab.Controls) {
                if ($ctrl -is [System.Windows.Forms.ListView]) {
                    $ctrl.BackColor = "White"
                    $ctrl.ForeColor = "Black"
                }
            }
        }
    }
}

# ==============================
# UI BUILD
# ==============================

$form = New-Object System.Windows.Forms.Form
$form.Text = "RMPIT Tech Toolkit v3.1"
$form.Size = New-Object System.Drawing.Size(900,650)
$form.StartPosition = "CenterScreen"

$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Size = New-Object System.Drawing.Size(840,450)
$tabControl.Location = New-Object System.Drawing.Point(20,60)
$form.Controls.Add($tabControl)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Size = New-Object System.Drawing.Size(600,25)
$progressBar.Location = New-Object System.Drawing.Point(20,540)
$form.Controls.Add($progressBar)

$statusBar = New-Object System.Windows.Forms.StatusStrip
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Ready"
$statusBar.Items.Add($statusLabel)
$form.Controls.Add($statusBar)

# Theme Dropdown
$themeBox = New-Object System.Windows.Forms.ComboBox
$themeBox.Items.AddRange(@("Dark","Light"))
$themeBox.SelectedIndex = 0
$themeBox.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($themeBox)

$themeBox.Add_SelectedIndexChanged({
    Apply-Theme $themeBox.SelectedItem
})

# ==============================
# LOAD SCRIPTS
# ==============================

Check-LauncherUpdate
$scripts = Load-Scripts

if ($scripts) {
    $categories = $scripts | Group-Object Category

    foreach ($cat in $categories) {

        $tab = New-Object System.Windows.Forms.TabPage
        $tab.Text = $cat.Name

        $list = New-Object System.Windows.Forms.ListView
        $list.View = "Details"
        $list.FullRowSelect = $true
        $list.GridLines = $true
        $list.Size = New-Object System.Drawing.Size(800,350)
        $list.Location = New-Object System.Drawing.Point(10,10)
        $list.Columns.Add("Script",250)
        $list.Columns.Add("Description",400)
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

Apply-Theme "Dark"
Write-Log "Launcher started"
$form.ShowDialog()
