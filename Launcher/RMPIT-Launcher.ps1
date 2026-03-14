
<# 
.NAME
    Windows 11 Toolkit

#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$RMPITApp3.0                     = New-Object system.Windows.Forms.Form
$RMPITApp3.0.ClientSize          = New-Object System.Drawing.Point(975,854)
$RMPITApp3.0.text                = "Windows 10 Debloat & System Helper By RMPIT LLC v.3.0"
$RMPITApp3.0.TopMost             = $false
$RMPITApp3.0.icon                = "https://raw.githubusercontent.com/rickpro2/Win10Reimage/main/RMPIT_logo.png"

$logo                            = New-Object system.Windows.Forms.PictureBox
$logo.width                      = 185
$logo.height                     = 50
$logo.location                   = New-Object System.Drawing.Point(36,764)
$logo.imageLocation              = "https://raw.githubusercontent.com/rickpro2/Win10Reimage/main/RMPIT_logo.png"
$logo.SizeMode                   = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$Step1                           = New-Object system.Windows.Forms.Label
$Step1.text                      = "Step #1"
$Step1.AutoSize                  = $true
$Step1.visible                   = $true
$Step1.enabled                   = $true
$Step1.width                     = 25
$Step1.height                    = 10
$Step1.location                  = New-Object System.Drawing.Point(74,115)
$Step1.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Title                           = New-Object system.Windows.Forms.Label
$Title.text                      = "Program Installation"
$Title.AutoSize                  = $true
$Title.width                     = 25
$Title.height                    = 10
$Title.location                  = New-Object System.Drawing.Point(10,10)
$Title.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',30,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$MajorSteps                      = New-Object system.Windows.Forms.Panel
$MajorSteps.height               = 140
$MajorSteps.width                = 950
$MajorSteps.location             = New-Object System.Drawing.Point(10,72)

$ActivateWindows1                = New-Object system.Windows.Forms.Button
$ActivateWindows1.text           = "Activate Windows"
$ActivateWindows1.width          = 175
$ActivateWindows1.height         = 50
$ActivateWindows1.location       = New-Object System.Drawing.Point(10,10)
$ActivateWindows1.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',16,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Debloat                         = New-Object system.Windows.Forms.Button
$Debloat.text                    = "Debloat Windows"
$Debloat.width                   = 175
$Debloat.height                  = 50
$Debloat.location                = New-Object System.Drawing.Point(198,10)
$Debloat.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',16,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Customize                       = New-Object system.Windows.Forms.Button
$Customize.text                  = "Customize"
$Customize.width                 = 175
$Customize.height                = 50
$Customize.location              = New-Object System.Drawing.Point(386,10)
$Customize.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',16,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ChocolateyAllApps               = New-Object system.Windows.Forms.Button
$ChocolateyAllApps.text          = "Install Chocolatey/Apps"
$ChocolateyAllApps.width         = 175
$ChocolateyAllApps.height        = 50
$ChocolateyAllApps.location      = New-Object System.Drawing.Point(574,10)
$ChocolateyAllApps.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Sysprep                         = New-Object system.Windows.Forms.Button
$Sysprep.text                    = "Sysprep Windows"
$Sysprep.width                   = 175
$Sysprep.height                  = 50
$Sysprep.location                = New-Object System.Drawing.Point(764,10)
$Sysprep.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',16,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$Step2                           = New-Object system.Windows.Forms.Label
$Step2.text                      = "Step #2"
$Step2.AutoSize                  = $true
$Step2.visible                   = $true
$Step2.enabled                   = $true
$Step2.width                     = 25
$Step2.height                    = 10
$Step2.location                  = New-Object System.Drawing.Point(263,115)
$Step2.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Step3                           = New-Object system.Windows.Forms.Label
$Step3.text                      = "Step #3"
$Step3.AutoSize                  = $true
$Step3.visible                   = $true
$Step3.enabled                   = $true
$Step3.width                     = 25
$Step3.height                    = 10
$Step3.location                  = New-Object System.Drawing.Point(455,115)
$Step3.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Step4                           = New-Object system.Windows.Forms.Label
$Step4.text                      = "Step #4"
$Step4.AutoSize                  = $true
$Step4.visible                   = $true
$Step4.enabled                   = $true
$Step4.width                     = 25
$Step4.height                    = 10
$Step4.location                  = New-Object System.Drawing.Point(642,115)
$Step4.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Step5                           = New-Object system.Windows.Forms.Label
$Step5.text                      = "Step #5"
$Step5.AutoSize                  = $true
$Step5.visible                   = $true
$Step5.enabled                   = $true
$Step5.width                     = 25
$Step5.height                    = 10
$Step5.location                  = New-Object System.Drawing.Point(831,115)
$Step5.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ExtraOptions                    = New-Object system.Windows.Forms.Panel
$ExtraOptions.height             = 210
$ExtraOptions.width              = 300
$ExtraOptions.location           = New-Object System.Drawing.Point(9,225)

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.text                    = "ActivateWindows1"
$Button1.width                   = 130
$Button1.height                  = 30
$Button1.location                = New-Object System.Drawing.Point(18,265)
$Button1.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ExtOpton                        = New-Object system.Windows.Forms.Label
$ExtOpton.text                   = "Extra Options"
$ExtOpton.AutoSize               = $true
$ExtOpton.width                  = 25
$ExtOpton.height                 = 10
$ExtOpton.location               = New-Object System.Drawing.Point(10,10)
$ExtOpton.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.text                    = "Button2"
$Button2.width                   = 130
$Button2.height                  = 30
$Button2.location                = New-Object System.Drawing.Point(10,80)
$Button2.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button3                         = New-Object system.Windows.Forms.Button
$Button3.text                    = "Button3"
$Button3.width                   = 130
$Button3.height                  = 30
$Button3.location                = New-Object System.Drawing.Point(10,120)
$Button3.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button4                         = New-Object system.Windows.Forms.Button
$Button4.text                    = "Button4"
$Button4.width                   = 130
$Button4.height                  = 30
$Button4.location                = New-Object System.Drawing.Point(10,160)
$Button4.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button5                         = New-Object system.Windows.Forms.Button
$Button5.text                    = "Button5"
$Button5.width                   = 130
$Button5.height                  = 30
$Button5.location                = New-Object System.Drawing.Point(160,40)
$Button5.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button6                         = New-Object system.Windows.Forms.Button
$Button6.text                    = "Button6"
$Button6.width                   = 130
$Button6.height                  = 30
$Button6.location                = New-Object System.Drawing.Point(160,80)
$Button6.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button7                         = New-Object system.Windows.Forms.Button
$Button7.text                    = "Button7"
$Button7.width                   = 130
$Button7.height                  = 30
$Button7.location                = New-Object System.Drawing.Point(160,120)
$Button7.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Button8                         = New-Object system.Windows.Forms.Button
$Button8.text                    = "Button8"
$Button8.width                   = 130
$Button8.height                  = 30
$Button8.location                = New-Object System.Drawing.Point(160,160)
$Button8.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 210
$Panel1.width                    = 300
$Panel1.location                 = New-Object System.Drawing.Point(324,225)

$RMPITApp3.0.controls.AddRange(@($logo,$Title,$MajorSteps,$ExtraOptions,$Button1,$Panel1))
$MajorSteps.controls.AddRange(@($Step1,$ActivateWindows1,$Debloat,$Customize,$ChocolateyAllApps,$Sysprep,$Step2,$Step3,$Step4,$Step5))
$ExtraOptions.controls.AddRange(@($ExtOpton,$Button2,$Button3,$Button4,$Button5,$Button6,$Button7,$Button8))



#region Activation
function ActivateWindows1 { 
$ProcName = "ActivateWindows1.ps1"
$RepoBase = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main"
$WebFile = "$RepoBase/Scripts/$ProcName"
Clear-Host
(New-Object System.Net.WebClient).DownloadFile($WebFile,"$env:APPDATA\$ProcName")
Start-Process ("$env:APPDATA\$ProcName") 
}




#endregion


$Button1.Add_Click({ ActivateWindows1 })



[void]$RMPITApp3.0.ShowDialog()