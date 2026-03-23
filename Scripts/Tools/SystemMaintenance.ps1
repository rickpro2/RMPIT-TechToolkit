# Requires -RunAsAdministrator

Write-Host "Starting System Maintenance Script..."

# --- 1. Create a System Restore Point ---

$description = "Automated Maintenance Restore Point - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
Write-Host "Attempting to create a System Restore Point: $description"

# Temporarily set the restore point frequency to 0 to bypass the 24-hour limit
$regKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore"
$propName = "SystemRestorePointFrequency"
$originalFreq = Get-ItemProperty -Path $regKeyPath -Name $propName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $propName
if ($originalFreq -ne 0) {
    Set-ItemProperty -Path $regKeyPath -Name $propName -Value 0 -Type DWORD -Force
    Write-Host "Temporarily bypassed 24-hour restore point limit."
}

# Create the restore point
try {
    Checkpoint-Computer -Description $description -RestorePointType "MODIFY_SETTINGS"
    Write-Host "System Restore Point created successfully."
} catch {
    Write-Error "Failed to create System Restore Point. Ensure System Restore is enabled on the C: drive."
    Write-Error $_.Exception.Message
}

# Restore the original restore point frequency if it was changed
if ($originalFreq -ne 0 -and $originalFreq -ne $null) {
    Set-ItemProperty -Path $regKeyPath -Name $propName -Value $originalFreq -Type DWORD -Force
    Write-Host "Restored original restore point frequency setting."
} elseif ($originalFreq -eq $null) {
    # If the key didn't exist, remove the one we created (default behavior)
    Remove-ItemProperty -Path $regKeyPath -Name $propName -ErrorAction SilentlyContinue
    Write-Host "Cleaned up temporary registry key."
}


# --- 2. Run Disk Clean-up (Automated) ---

Write-Host "Starting Disk Clean-up..."

# Use /sageset to select all items for cleanup and save the settings with ID 1
# This part requires a one-time manual interaction or prior configuration on a new system
# Start-Process cleanmgr.exe -ArgumentList "/sageset:1" -Wait

# Run Disk Cleanup silently with the saved settings ID 1
# This command runs without user interaction after settings are saved
Start-Process cleanmgr.exe -ArgumentList "/sagerun:1" -Wait
Write-Host "Disk Clean-up process initiated and completed."

Write-Host "Script Finished."
