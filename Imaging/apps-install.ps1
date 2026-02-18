# Ensure winget is ready (optional, helps if the Store update is slow)
Write-Host "Registering App Installer..."
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
# Wait a moment for registration to complete if necessary in some environments
Start-Sleep -Seconds 10

Install applications silently with accepted agreements
Write-Host "Starting application installations..."

winget install --id Google.Chrome --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Brave.Brave --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id VideoLAN.VLC --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id 7zip.7zip --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Notepad++.Notepad++ --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Zoom.Zoom --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Adobe.Acrobat.Reader.64-bit --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Microsoft.Office --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Malwarebytes.Malwarebytes --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Romanitho.Winget-AutoUpdate --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id Romanitho.WiGUI --silent --accept-source-agreements --accept-package-agreements --scope machine
winget install --id TorProject.TorBrowser --silent --accept-source-agreements --accept-package-agreements --scope machine

Write-Host "Installation script finished."
