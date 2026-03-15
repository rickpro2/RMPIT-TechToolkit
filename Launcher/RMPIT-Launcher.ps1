
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

$logo                            = New-Object system.Windows.Forms.PictureBox
$logo.width                      = 60
$logo.height                     = 30
$logo.location                   = New-Object System.Drawing.Point(42,518)
$logo.imageLocation              = "https://github.com/rickpro2/RMPIT-TechToolkit/logo.png"
$logo.SizeMode                   = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$RMPITTechToolkit.controls.AddRange(@($logo))







[void]$RMPITTechToolkit.ShowDialog()