# Requires -RunAsAdministrator for best results, especially with taskbar settings

# --- 1. Enable showing seconds in the taskbar clock ---
# This registry change works for Windows 10 and 11
Write-Host "Enabling 'show seconds' in the taskbar clock..."
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$propertyName = "ShowSecondsInSystemClock"
$value = 1

# Set the registry property
try {
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value $value -Force
    Write-Host "'Show seconds' enabled in the registry. Explorer needs to be restarted for this to take effect."
} catch {
    Write-Host "Error setting registry property for taskbar clock: $_"
}

# --- 2. Attempt to sort desktop icons by "Item Type" ---
# This part is complex because Windows manages icon layout dynamically and an exact setting via
# simple registry key for "sort by item type" isn't consistently available across versions.
# A common programmatic approach involves sending keystrokes to the desktop, which can be unreliable.

# An alternative for consistent sorting is to enforce "Auto Arrange" via registry, which helps organize
# them, but does not guarantee the sort *criteria* itself (Name, Type, etc.)
Write-Host "Setting desktop to 'Auto Arrange' and 'Medium Icons' (a common configuration)..."
$bagsPath = 'HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop'
if (Test-Path $bagsPath) {
    Set-ItemProperty -Path $bagsPath -Name 'LogicalViewMode' -Value 1 # Auto Arrange
    Set-ItemProperty -Path $bagsPath -Name 'IconSize' -Value 0 # Medium Icons
    Write-Host "Auto Arrange set. The exact 'Sort by Item Type' is a user interaction or less direct registry setting."
} else {
    Write-Host "Desktop registry path not found. Cannot apply Auto Arrange setting."
}


# --- 3. Restart Explorer to apply changes ---
Write-Host "Restarting Windows Explorer to apply changes. The screen may flicker."
# Stop explorer.exe process
Get-Process -Name "explorer" -ErrorAction Stop | Stop-Process
# Start explorer.exe process again (it will auto-restart if stopped)
Start-Sleep -Seconds 2
Start-Process -FilePath "explorer.exe"
