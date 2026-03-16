
<# 
.NAME
    This is at test

#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$RMPITTechToolkit                = New-Object system.Windows.Forms.Form
$RMPITTechToolkit.ClientSize     = New-Object System.Drawing.Point(975,600)
$RMPITTechToolkit.text           = "Windows 11 Debloat & System Helper By RMPIT LLC v.1.1"
$RMPITTechToolkit.TopMost        = $false
$RMPITTechToolkit.icon           = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/favicon.ico"

$logo                            = New-Object system.Windows.Forms.PictureBox
$logo.width                      = 185
$logo.height                     = 50
$logo.location                   = New-Object System.Drawing.Point(42,518)
$logo.imageLocation              = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/logo.png"
$logo.SizeMode                   = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$ActivationPanel                 = New-Object system.Windows.Forms.Panel
$ActivationPanel.height          = 210
$ActivationPanel.width           = 300
$ActivationPanel.location        = New-Object System.Drawing.Point(9,225)

$ActivationLabel                 = New-Object system.Windows.Forms.Label
$ActivationLabel.text            = "Activation"
$ActivationLabel.AutoSize        = $true
$ActivationLabel.width           = 25
$ActivationLabel.height          = 10
$ActivationLabel.location        = New-Object System.Drawing.Point(15,11)
$ActivationLabel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$ActivateWindows1                = New-Object system.Windows.Forms.Button
$ActivateWindows1.text           = "Activate Windows 1"
$ActivateWindows1.width          = 148
$ActivateWindows1.height         = 30
$ActivateWindows1.location       = New-Object System.Drawing.Point(12,52)
$ActivateWindows1.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ActivateWindows2                = New-Object system.Windows.Forms.Button
$ActivateWindows2.text           = "Activate Windows 2"
$ActivateWindows2.width          = 148
$ActivateWindows2.height         = 30
$ActivateWindows2.location       = New-Object System.Drawing.Point(12,92)
$ActivateWindows2.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$InstallerPanel                  = New-Object system.Windows.Forms.Panel
$InstallerPanel.height           = 210
$InstallerPanel.width            = 300
$InstallerPanel.location         = New-Object System.Drawing.Point(329,225)

$InstallerLabel                  = New-Object system.Windows.Forms.Label
$InstallerLabel.text             = "Install"
$InstallerLabel.AutoSize         = $true
$InstallerLabel.width            = 25
$InstallerLabel.height           = 10
$InstallerLabel.location         = New-Object System.Drawing.Point(15,11)
$InstallerLabel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$InsallApps1                     = New-Object system.Windows.Forms.Button
$InsallApps1.text                = "Apps 1"
$InsallApps1.width               = 148
$InsallApps1.height              = 30
$InsallApps1.location            = New-Object System.Drawing.Point(12,52)
$InsallApps1.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$InsallApps2                     = New-Object system.Windows.Forms.Button
$InsallApps2.text                = "Apps 2"
$InsallApps2.width               = 148
$InsallApps2.height              = 30
$InsallApps2.location            = New-Object System.Drawing.Point(12,92)
$InsallApps2.Font                = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 210
$Panel1.width                    = 300
$Panel1.location                 = New-Object System.Drawing.Point(653,225)

$ToolsLabel                      = New-Object system.Windows.Forms.Label
$ToolsLabel.text                 = "Tools"
$ToolsLabel.AutoSize             = $true
$ToolsLabel.width                = 25
$ToolsLabel.height               = 10
$ToolsLabel.location             = New-Object System.Drawing.Point(15,11)
$ToolsLabel.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$CTWTButton                      = New-Object system.Windows.Forms.Button
$CTWTButton.text                 = "Chris Titus Windows Tool"
$CTWTButton.width                = 148
$CTWTButton.height               = 30
$CTWTButton.location             = New-Object System.Drawing.Point(12,52)
$CTWTButton.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RMPITTechToolkit.controls.AddRange(@($logo,$ActivationPanel,$InstallerPanel,$Panel1))
$ActivationPanel.controls.AddRange(@($ActivationLabel,$ActivateWindows1,$ActivateWindows2))
$InstallerPanel.controls.AddRange(@($InstallerLabel,$InsallApps1,$InsallApps2))
$Panel1.controls.AddRange(@($ToolsLabel,$CTWTButton))

<#
function Run-RMPITScript {

param(
    [string]$ScriptName,
    [string]$RepoURL
)

$LocalFile = "$env:TEMP\$ScriptName"
$WebFile   = "$RepoURL/$ScriptName"

# Download script
Invoke-WebRequest $WebFile -OutFile $LocalFile -UseBasicParsing

$Extension = [System.IO.Path]::GetExtension($ScriptName)

switch ($Extension) {

    ".ps1" {
        Start-Process powershell.exe -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -NoProfile -Command `"& '$LocalFile'; Remove-Item '$LocalFile' -Force`""
    }

    ".bat" {
        Start-Process cmd.exe -Verb RunAs -ArgumentList "/c `"$LocalFile && del $LocalFile`""
    }

    ".cmd" {
        Start-Process cmd.exe -Verb RunAs -ArgumentList "/c `"$LocalFile && del $LocalFile`""
    }

    default {
        Start-Process $LocalFile -Verb RunAs
    }

}

}

$ToolkitRepo = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/Scripts"
#>



# =====================================================
# RMPIT Toolkit Script Runner
# Supports PS1 / BAT / CMD / EXE
# Auto Admin Elevation + Auto Cleanup
# =====================================================

function Run-RMPITScript {

param(
    [string]$ScriptName,
    [string]$RepoURL
)

$LocalFile = "$env:TEMP\$ScriptName"
$WebFile   = "$RepoURL/$ScriptName"

try {

    # Download Script
    Invoke-WebRequest $WebFile -OutFile $LocalFile -UseBasicParsing

}
catch {

    [System.Windows.Forms.MessageBox]::Show("Failed to download script:`n$WebFile","Download Error")
    return

}

$Extension = [System.IO.Path]::GetExtension($ScriptName)

switch ($Extension) {

    ".ps1" {

        Start-Process powershell.exe `
        -Verb RunAs `
        -ArgumentList "-ExecutionPolicy Bypass -NoProfile -Command `"& '$LocalFile'; Remove-Item '$LocalFile' -Force`""

    }

    ".bat" {

        Start-Process cmd.exe `
        -Verb RunAs `
        -ArgumentList "/c `"$LocalFile && del $LocalFile`""

    }

    ".cmd" {

        Start-Process cmd.exe `
        -Verb RunAs `
        -ArgumentList "/c `"$LocalFile && del $LocalFile`""

    }

    ".exe" {

        Start-Process $LocalFile -Verb RunAs
    }

    default {

        Start-Process $LocalFile -Verb RunAs

    }

}

}

# =====================================================
# GitHub Script Locations
# =====================================================

$ScriptsRoot = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/Scripts"

$ActivationRepo = "$ScriptsRoot/Activation"
$AppsRepo       = "$ScriptsRoot/Installers"
$ToolsRepo     = "$ScriptsRoot/Tools"

#region Activation
# Activation 1
function ActivateWindows1 {
Run-RMPITScript "ActivateWindows1.ps1" $ActivationRepo
}

# Activation 2
function ActivateWindows2 {
Run-RMPITScript "ActivateWindows2.ps1" $ActivationRepo
}

#endregion

#region Installers
# Installer 1
function apps1 {
Run-RMPITScript "apps-install.ps1" $AppsRepo
}

# Installer 2
function apps2 {
Run-RMPITScript "apps-install2.ps1" $AppsRepo
}
#endregion

#region Tools
# Chris Titus Windows Tool
function ActivateWindows1 {
Run-RMPITScript "CTWT.ps1" $ToolsRepo
}
#endregion


$ActivateWindows1.Add_Click({ ActivateWindows1 })
$ActivateWindows2.Add_Click({ ActivateWindows2 })
$InsallApps1.Add_Click({ apps1 })
$InsallApps2.Add_Click({ apps2 })
$CTWTButton.Add_Click({ CTWT })



[void]$RMPITTechToolkit.ShowDialog()