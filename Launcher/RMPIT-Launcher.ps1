
<# 
.NAME
    RMPIT Win11 Toolkit
.SYNOPSIS
    Scripts to help windows 11 installations
.DESCRIPTION
    This is a list of scripts to help make windows better.

#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$RMPITTechToolkit                = New-Object system.Windows.Forms.Form
$RMPITTechToolkit.ClientSize     = New-Object System.Drawing.Point(975,600)
$RMPITTechToolkit.text           = "Windows 11 Debloat & System Helper By RMPIT LLC v.2.7"
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

$ActivateWindows1Button          = New-Object system.Windows.Forms.Button
$ActivateWindows1Button.text     = "Activate Windows 1"
$ActivateWindows1Button.width    = 148
$ActivateWindows1Button.height   = 30
$ActivateWindows1Button.location  = New-Object System.Drawing.Point(12,52)
$ActivateWindows1Button.Font     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ActivateWindows2Button          = New-Object system.Windows.Forms.Button
$ActivateWindows2Button.text     = "Activate Windows 2"
$ActivateWindows2Button.width    = 148
$ActivateWindows2Button.height   = 30
$ActivateWindows2Button.location  = New-Object System.Drawing.Point(12,92)
$ActivateWindows2Button.Font     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$InstallerPanel                  = New-Object system.Windows.Forms.Panel
$InstallerPanel.height           = 210
$InstallerPanel.width            = 300
$InstallerPanel.location         = New-Object System.Drawing.Point(329,225)

$InstallerLabel                  = New-Object system.Windows.Forms.Label
$InstallerLabel.text             = "Installers"
$InstallerLabel.AutoSize         = $true
$InstallerLabel.width            = 25
$InstallerLabel.height           = 10
$InstallerLabel.location         = New-Object System.Drawing.Point(15,11)
$InstallerLabel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$InstallApps1Button              = New-Object system.Windows.Forms.Button
$InstallApps1Button.text         = "Apps 1"
$InstallApps1Button.width        = 148
$InstallApps1Button.height       = 30
$InstallApps1Button.location     = New-Object System.Drawing.Point(12,52)
$InstallApps1Button.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$InstallApps2Button              = New-Object system.Windows.Forms.Button
$InstallApps2Button.text         = "Apps 2"
$InstallApps2Button.width        = 148
$InstallApps2Button.height       = 30
$InstallApps2Button.location     = New-Object System.Drawing.Point(12,92)
$InstallApps2Button.Font         = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

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

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 172
$Panel2.width                    = 300
$Panel2.location                 = New-Object System.Drawing.Point(653,28)

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Testing"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(15,17)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$ActivateOfficeButton            = New-Object system.Windows.Forms.Button
$ActivateOfficeButton.text       = "Activate Microsoft Office"
$ActivateOfficeButton.width      = 148
$ActivateOfficeButton.height     = 30
$ActivateOfficeButton.location   = New-Object System.Drawing.Point(12,133)
$ActivateOfficeButton.Font       = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$tor                             = New-Object system.Windows.Forms.Button
$tor.text                        = "The Onion Browser"
$tor.width                       = 148
$tor.height                      = 30
$tor.location                    = New-Object System.Drawing.Point(12,171)
$tor.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 172
$Panel3.width                    = 300
$Panel3.location                 = New-Object System.Drawing.Point(11,28)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Advance Users Only"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(13,14)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))
$Label2.ForeColor                = [System.Drawing.ColorTranslator]::FromHtml("#d0021b")

$SystemMaintenance               = New-Object system.Windows.Forms.Button
$SystemMaintenance.text          = "System Maintenance"
$SystemMaintenance.width         = 148
$SystemMaintenance.height        = 30
$SystemMaintenance.location      = New-Object System.Drawing.Point(12,97)
$SystemMaintenance.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "Apps 3"
$Button1.width                   = 148
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(12,131)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Time"
$Button2.width                   = 148
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(12,142)
$Button2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RMPITTechToolkit.controls.AddRange(@($logo,$ActivationPanel,$InstallerPanel,$Panel1,$Panel2,$Panel3))
$ActivationPanel.controls.AddRange(@($ActivationLabel,$ActivateWindows1Button,$ActivateWindows2Button,$ActivateOfficeButton))
$InstallerPanel.controls.AddRange(@($InstallerLabel,$InstallApps1Button,$InstallApps2Button,$tor,$Button1))
$Panel1.controls.AddRange(@($ToolsLabel,$CTWTButton,$SystemMaintenance,$Button2))
$Panel2.controls.AddRange(@($Label1))
$Panel3.controls.AddRange(@($Label2))

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
    -Wait `
    -ArgumentList "/c `"$LocalFile`""

    Remove-Item $LocalFile -Force
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
$TestingRepo     = "$ScriptsRoot/testing"

#region Activation
# Windows Activation 1
function ActivateWindows1 {
Run-RMPITScript "ActivateWindows1.ps1" $ActivationRepo
}

# Windows Activation 2
function ActivateWindows2 {
Run-RMPITScript "ActivateWindows2.ps1" $ActivationRepo
}

# Offcie 365 Activation
function ActivateOffice {
Run-RMPITScript "Activate-Office.bat" $ActivationRepo
}
#endregion

#region Installers
# Apps Installer 1
function apps1 {
Run-RMPITScript "apps-install.ps1" $AppsRepo
}

# Apps Installer 2
function apps2 {
Run-RMPITScript "apps-install2.ps1" $AppsRepo
}

# Apps Installer 3
function apps3 {
Run-RMPITScript "apps-install3.ps1" $AppsRepo
}

# The Onion Browser
function OnionBrowser {
Run-RMPITScript "tor.ps1" $AppsRepo
}

#endregion

#region Tools
# Chris Titus Windows Tool
function CTWT {
Run-RMPITScript "CTWT.ps1" $ToolsRepo
}

# SystemMaintenance
# Runs a system restore point and run Disk Clean-up
function SystemMaintenance {
Run-RMPITScript "SystemMaintenance.ps1" $ToolsRepo
}

# Time
# Put's Seconds on time
function time {
Run-RMPITScript "time.ps1" $ToolsRepo
}
#endregion

#region testing

# winscript
function winscript {
Run-RMPITScript "winscript.ps1" $TestingRepo
}
#endregion


$ActivateWindows1Button.Add_Click({ ActivateWindows1 })
$ActivateWindows2Button.Add_Click({ ActivateWindows2 })
$InstallApps1Button.Add_Click({ apps1 })
$InstallApps2Button.Add_Click({ apps2 })
$CTWTButton.Add_Click({ CTWT })
$ActivateOfficeButton.Add_Click({ ActivateOffice })
$tor.Add_Click({ OnionBrowser })
$SystemMaintenance.Add_Click({ SystemMaintenance })
$Button1.Add_Click({ apps3 })
$Button2.Add_Click({ time })



[void]$RMPITTechToolkit.ShowDialog()