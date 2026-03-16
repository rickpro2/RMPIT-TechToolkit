
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
$ActivationLabel.location        = New-Object System.Drawing.Point(12,13)
$ActivationLabel.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$ActivateWindows1                = New-Object system.Windows.Forms.Button
$ActivateWindows1.text           = "Activate Windows 3"
$ActivateWindows1.width          = 130
$ActivateWindows1.height         = 30
$ActivateWindows1.location       = New-Object System.Drawing.Point(12,39)
$ActivateWindows1.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$RMPITTechToolkit.controls.AddRange(@($logo,$ActivationPanel))
$ActivationPanel.controls.AddRange(@($ActivationLabel,$ActivateWindows1))







[void]$RMPITTechToolkit.ShowDialog()