

function Get-HotReload {
     
     $Form.Close()
     $headers = @{Authorization = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5YjczMWMxMzMxNmQwYzQ2NTJkM2I5YyIsImlhdCI6MTc3MzYxNTIwNiwiZXhwIjoxNzczNjE1NTA2fQ.tMWafdf38cQMRPhdLmTmmHqvEp6mdQJ7N_vhyGot0WI"}
     $response = Invoke-RestMethod -Uri "https://app.poshgui.com/api/hotreload/winform/69b731c13316d0c4652d3b9c" -Method Get -Headers $headers
     iex $response
    }

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
$logo.width                      = 60
$logo.height                     = 30
$logo.location                   = New-Object System.Drawing.Point(42,518)
$logo.imageLocation              = "https://raw.githubusercontent.com/rickpro2/RMPIT-TechToolkit/main/logo.png"
$logo.SizeMode                   = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$hotreload                       = New-Object system.Windows.Forms.PictureBox
$hotreload.width                 = 60
$hotreload.height                = 30
$hotreload.location              = New-Object System.Drawing.Point(915,1)
$hotreload.imageLocation         = "https://app.poshgui.com/images/refresh.png"
$hotreload.SizeMode              = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$RMPITTechToolkit.controls.AddRange(@($logo,$hotreload))






$hotreload.Add_Click({Get-HotReload})


[void]$RMPITTechToolkit.ShowDialog()