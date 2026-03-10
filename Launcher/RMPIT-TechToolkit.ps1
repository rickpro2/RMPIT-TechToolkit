# =====================================================
# RMPIT Tech Toolkit v4
# https://github.com/rickpro2/RMPIT-TechToolkit
# =====================================================

# ==============================
# FORCE ADMIN
# ==============================

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {

    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-ExecutionPolicy Bypass -NoProfile -File `"$PSCommandPath`""
    $psi.Verb = "runas"

    try { [System.Diagnostics.Process]::Start($psi) | Out-Null }
    catch { exit }

    exit
}

# ==============================
# IMPORT GUI LIBRARIES
# ==============================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# ==============================
# CONFIG
# ==============================

$Version = "4.0.2"
$RepoBase = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main"
$IconURL = "$RepoBase/Assets/icon.ico"

# ==============================
# DOWNLOAD ICON
# ==============================

$tempIcon = "$env:TEMP\rmpit.ico"

try {
    Invoke-WebRequest $IconURL -OutFile $tempIcon -UseBasicParsing
} catch {}

# ==============================
# FORM
# ==============================

$form = New-Object System.Windows.Forms.Form
$form.Text = "RMPIT Tech Toolkit v$Version"
$form.Size = New-Object System.Drawing.Size(1000,700)
$form.StartPosition = "CenterScreen"

if (Test-Path $tempIcon) {
    $form.Icon = New-Object System.Drawing.Icon($tempIcon)
}

# ==============================
# TITLE
# ==============================

$title = New-Object System.Windows.Forms.Label
$title.Text = "RMPIT Tech Toolkit"
$title.Font = New-Object System.Drawing.Font("Segoe UI",18,[System.Drawing.FontStyle]::Bold)
$title.AutoSize = $true
$title.Location = New-Object System.Drawing.Point(20,20)

$form.Controls.Add($title)

# ==============================
# TAB CONTROL
# ==============================

$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Size = New-Object System.Drawing.Size(940,400)
$tabs.Location = New-Object System.Drawing.Point(20,70)

$form.Controls.Add($tabs)

# ==============================
# OUTPUT CONSOLE
# ==============================

$output = New-Object System.Windows.Forms.TextBox
$output.Multiline = $true
$output.ScrollBars = "Vertical"
$output.Size = New-Object System.Drawing.Size(940,150)
$output.Location = New-Object System.Drawing.Point(20,480)
$output.ReadOnly = $true

$form.Controls.Add($output)

$clearBtn = New-Object System.Windows.Forms.Button
$clearBtn.Text = "Clear Console"
$clearBtn.Size = New-Object System.Drawing.Size(120,30)
$clearBtn.Location = New-Object System.Drawing.Point(840,440)

$clearBtn.Add_Click({
    $output.Clear()
})

$form.Controls.Add($clearBtn)

# ==============================
# STATUS BAR
# ==============================

$statusBar = New-Object System.Windows.Forms.StatusStrip
$statusLabel = New-Object System.Windows.Forms.ToolStripStatusLabel
$statusLabel.Text = "Ready"

$statusBar.Items.Add($statusLabel)
$form.Controls.Add($statusBar)
$statusBar.Dock = "Bottom"

# ==============================
# OUTPUT WRITER
# ==============================

function Write-OutputBox {

    param($text)

    $output.AppendText("$text`r`n")
    $output.SelectionStart = $output.Text.Length
    $output.ScrollToCaret()
}

# ==============================
# RUN REMOTE SCRIPT
# ==============================

function Run-Tool {

    param(
        [string]$Name,
        [string]$URL
    )

    try {

        Write-OutputBox "Launching $Name..."

        $file = [System.IO.Path]::GetFileName($URL)
        $temp = Join-Path $env:TEMP $file

        # If it's a direct script file, download it
        if ($URL -match "\.(ps1|bat|cmd|exe)$") {

            Invoke-WebRequest $URL -OutFile $temp -UseBasicParsing

            switch -Regex ($file) {

                "\.ps1$" {
                    Start-Process powershell.exe `
                    -ArgumentList "-ExecutionPolicy Bypass -NoProfile -File `"$temp`"" `
                    -Verb RunAs
                }

                "\.(bat|cmd)$" {
                    Start-Process cmd.exe `
                    -ArgumentList "/c `"$temp`"" `
                    -Verb RunAs
                }

                "\.exe$" {
                    Start-Process $temp -Verb RunAs
                }

            }

        }
        else {

            # Treat as IRM script
            Start-Process powershell.exe `
            -ArgumentList "-ExecutionPolicy Bypass -NoProfile -Command `"irm '$URL' | iex`"" `
            -Verb RunAs

        }

        $statusLabel.Text = "Running $Name"

    }
    catch {

        Write-OutputBox "Failed to launch $Name"
        $statusLabel.Text = "Error"

    }

}

# ==============================
# CREATE TAB FUNCTION
# ==============================

function New-ToolkitTab {

    param($Name)

    $tab = New-Object System.Windows.Forms.TabPage
    $tab.Text = $Name

    $tabs.TabPages.Add($tab)

    return $tab
}

# ==============================
# CREATE BUTTON FUNCTION
# ==============================

function Add-ToolkitButton {

    param(
        $Tab,
        $Text,
        $X,
        $Y,
        $ScriptName,
        $ScriptURL
    )

    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $Text
    $btn.Size = New-Object System.Drawing.Size(200,40)
    $btn.Location = New-Object System.Drawing.Point($X,$Y)

    $btn.Add_Click({
        Run-Tool $ScriptName $ScriptURL
    })

    $Tab.Controls.Add($btn)
}

# ==============================
# CREATE TABS
# ==============================

$tabActivation = New-ToolkitTab "Activation"
$tabSystem = New-ToolkitTab "System Tools"
$tabInstall = New-ToolkitTab "Installers"
$tabRepair = New-ToolkitTab "Repair"

# ==============================
# ACTIVATION BUTTONS
# ==============================

Add-ToolkitButton `
$tabActivation `
"Activate Windows" `
20 `
20 `
"Windows Activation (a)" `
"$RepoBase/ACTIVATION/a.ps1"

Add-ToolkitButton `
$tabActivation `
"Activate Windows" `
20 `
70 `
"Windows Activation (b)" `
"$RepoBase/ACTIVATION/a.cmd"

Add-ToolkitButton `
$tabActivation `
"Activate Windows" `
20 `
120 `
"Windows Activation (c)" `
"$RepoBase/ACTIVATION/a.cmd"

Add-ToolkitButton `
$tabActivation `
"Activate Office" `
20 `
170 `
"Office Activation" `
"$RepoBase/ACTIVATION/a.ps1"

# ==============================
# SYSTEM TOOLS
# ==============================

Add-ToolkitButton `
$tabSystem `
"Windows Debloat" `
20 `
20 `
"Windows Debloat" `
"https://christitus.com/win"

Add-ToolkitButton `
$tabSystem `
"Enable Dark Mode" `
20 `
80 `
"Dark Mode" `
"$RepoBase/Scripts/enable-darkmode.ps1"

# ==============================
# INSTALLERS
# ==============================

Add-ToolkitButton `
$tabInstall `
"Install Chocolatey Apps" `
20 `
20 `
"Chocolatey Apps" `
"$RepoBase/Scripts/install-apps.ps1"

Add-ToolkitButton `
$tabInstall `
"Install Winget Apps" `
20 `
80 `
"Winget Apps" `
"$RepoBase/Scripts/install-winget.ps1"

# ==============================
# REPAIR TOOLS
# ==============================

Add-ToolkitButton `
$tabRepair `
"Windows Repair (SFC)" `
20 `
20 `
"SFC Repair" `
"$RepoBase/Scripts/sfc-repair.ps1"

Add-ToolkitButton `
$tabRepair `
"DISM Repair" `
20 `
80 `
"DISM Repair" `
"$RepoBase/Scripts/dism-repair.ps1"

# ==============================
# THEME
# ==============================

function Set-DarkMode {

$form.BackColor = "#1e1e1e"
$form.ForeColor = "White"
$output.BackColor = "#2d2d2d"
$output.ForeColor = "White"

foreach ($tab in $tabs.TabPages) {

    $tab.BackColor = "#1e1e1e"

    foreach ($ctrl in $tab.Controls) {

        if ($ctrl -is [System.Windows.Forms.Button]) {
            $ctrl.BackColor = "#333"
            $ctrl.ForeColor = "White"
        }

    }

}

}

Set-DarkMode

# ==============================
# START
# ==============================

Write-OutputBox "RMPIT Tech Toolkit Started"
Write-OutputBox "Version $Version"

$form.ShowDialog()