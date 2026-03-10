# =====================================================
# RMPIT Tech Toolkit v4.1
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

$Version = "4.1"
$RepoBase = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main"
$IconURL = "$RepoBase/Assets/icon.ico"

# ==============================
# AUTO UPDATE
# ==============================

$VersionURL = "$RepoBase/Launcher/version.txt"
$LauncherURL = "$RepoBase/Launcher/RMPIT-TechToolkit.ps1"

function Check-ToolkitUpdate {

    try {

        $remote = (Invoke-RestMethod $VersionURL).Trim()

        if ($remote -ne $Version) {

            $result = [System.Windows.Forms.MessageBox]::Show(
                "New version ($remote) available. Update now?",
                "Toolkit Update",
                "YesNo",
                "Information"
            )

            if ($result -eq "Yes") {

                $temp = "$env:TEMP\RMPIT-TechToolkit.ps1"

                Invoke-WebRequest $LauncherURL -OutFile $temp

                Start-Process powershell `
                -ArgumentList "-ExecutionPolicy Bypass -File `"$temp`"" `
                -Verb RunAs

                exit
            }
        }

    } catch {}
}

Check-ToolkitUpdate

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
# DARK MODE TOGGLE
# ==============================

$themeToggle = New-Object System.Windows.Forms.CheckBox
$themeToggle.Text = "Dark Mode"
$themeToggle.Location = New-Object System.Drawing.Point(220,28)
$form.Controls.Add($themeToggle)

# ==============================
# SEARCH BOX
# ==============================

$searchBox = New-Object System.Windows.Forms.TextBox
$searchBox.Size = New-Object System.Drawing.Size(300,25)
$searchBox.Location = New-Object System.Drawing.Point(640,25)
$form.Controls.Add($searchBox)

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

# ==============================
# CLEAR BUTTON
# ==============================

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
        $statusLabel.Text = "Running $Name"

        if ($URL -match "^https://christitus.com") {

            Start-Process powershell `
            -ArgumentList "-ExecutionPolicy Bypass -NoProfile -Command `"irm '$URL' | iex`"" `
            -Verb RunAs

            return
        }

        $file = [System.IO.Path]::GetFileName($URL)
        $temp = Join-Path $env:TEMP $file

        Invoke-WebRequest $URL -OutFile $temp -UseBasicParsing

        switch -Regex ($file) {

            "\.ps1$" {
                Start-Process powershell `
                -ArgumentList "-ExecutionPolicy Bypass -File `"$temp`"" `
                -Verb RunAs
            }

            "\.(bat|cmd)$" {
                Start-Process cmd `
                -ArgumentList "/c `"$temp`"" `
                -Verb RunAs
            }

            "\.exe$" {
                Start-Process $temp -Verb RunAs
            }
        }

    }
    catch {

        Write-OutputBox "Error running $Name"
        $statusLabel.Text = "Error"

    }
}

# ==============================
# CREATE TAB
# ==============================

function New-ToolkitTab {

    param($Name)

    $tab = New-Object System.Windows.Forms.TabPage
    $tab.Text = $Name
    $tabs.TabPages.Add($tab)

    return $tab
}

# ==============================
# CREATE BUTTON
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
# BUTTONS
# ==============================

Add-ToolkitButton $tabActivation "Activate Windows" 20 20 "Windows Activation A" "$RepoBase/ACTIVATION/a.ps1"
Add-ToolkitButton $tabActivation "Activate Windows B" 20 70 "Windows Activation B" "$RepoBase/ACTIVATION/a.cmd"
Add-ToolkitButton $tabActivation "Activate Windows C" 20 120 "Windows Activation C" "$RepoBase/ACTIVATION/a.cmd"
Add-ToolkitButton $tabActivation "Activate Office" 20 170 "Office Activation" "$RepoBase/ACTIVATION/a.ps1"

Add-ToolkitButton $tabSystem "Chris Titus Windows Tool" 20 20 "Chris Titus Tool" "https://christitus.com/win"
Add-ToolkitButton $tabSystem "Enable Dark Mode" 20 80 "Dark Mode Script" "$RepoBase/Scripts/enable-darkmode.ps1"

Add-ToolkitButton $tabInstall "Install Chocolatey Apps" 20 20 "Chocolatey Apps" "$RepoBase/Scripts/install-apps.ps1"
Add-ToolkitButton $tabInstall "Install Winget Apps" 20 80 "Winget Apps" "$RepoBase/Scripts/install-winget.ps1"

Add-ToolkitButton $tabRepair "SFC Repair" 20 20 "SFC Repair" "$RepoBase/Scripts/sfc-repair.ps1"
Add-ToolkitButton $tabRepair "DISM Repair" 20 80 "DISM Repair" "$RepoBase/Scripts/dism-repair.ps1"

# ==============================
# THEME FUNCTIONS
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

function Set-LightMode {

$form.BackColor = "White"
$form.ForeColor = "Black"
$output.BackColor = "White"
$output.ForeColor = "Black"

foreach ($tab in $tabs.TabPages) {

    $tab.BackColor = "White"

    foreach ($ctrl in $tab.Controls) {

        if ($ctrl -is [System.Windows.Forms.Button]) {
            $ctrl.BackColor = "Gainsboro"
            $ctrl.ForeColor = "Black"
        }
    }
}

}

$themeToggle.Add_CheckedChanged({

    if ($themeToggle.Checked) { Set-DarkMode }
    else { Set-LightMode }

})

Set-LightMode

# ==============================
# SEARCH
# ==============================

$searchBox.Add_TextChanged({

$query = $searchBox.Text.ToLower()

foreach ($tab in $tabs.TabPages) {

    foreach ($ctrl in $tab.Controls) {

        if ($ctrl -is [System.Windows.Forms.Button]) {

            if ($ctrl.Text.ToLower().Contains($query)) {
                $ctrl.Visible = $true
            } else {
                $ctrl.Visible = $false
            }
        }
    }
}

})

# ==============================
# START
# ==============================

Write-OutputBox "RMPIT Tech Toolkit Started"
Write-OutputBox "Version $Version"

$form.ShowDialog()