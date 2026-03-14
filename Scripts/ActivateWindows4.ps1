# Ensure TLS 1.2+
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$tempFile = "$env:TEMP\rmp-activate.ps1"

# Download the script
Invoke-RestMethod "https://get.activated.win" -OutFile $tempFile

# Optional: You could hash-check or inspect here

# Execute it
& $tempFile