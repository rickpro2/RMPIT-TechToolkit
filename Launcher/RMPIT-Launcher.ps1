

function Get-HotReload {
     
     $Form.Close()
     $headers = @{Authorization = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5YjczMWMxMzMxNmQwYzQ2NTJkM2I5YyIsImlhdCI6MTc3MzYxMzU0NCwiZXhwIjoxNzczNjEzODQ0fQ.ZySJF2IwbPHeEOozM6ONl3qS6YK7tTo-TWMFghotP2M"}
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
$RMPITTechToolkit.ClientSize     = New-Object System.Drawing.Point(400,400)
$RMPITTechToolkit.text           = "Form"
$RMPITTechToolkit.TopMost        = $false

$hotreload                       = New-Object system.Windows.Forms.PictureBox
$hotreload.width                 = 60
$hotreload.height                = 30
$hotreload.location              = New-Object System.Drawing.Point(340,1)
$hotreload.imageLocation         = "https://app.poshgui.com/images/refresh.png"
$hotreload.SizeMode              = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$RMPITTechToolkit.controls.AddRange(@($hotreload))






$hotreload.Add_Click({Get-HotReload})


[void]$RMPITTechToolkit.ShowDialog()