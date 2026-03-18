# Define the URL of the .exe file you want to download
$url = "https://rickieproctor.com/tor.exe"

# Get the current user's desktop path
$desktopPath = [Environment]::GetFolderPath("Desktop")

# Define the full path for the downloaded file
$outputFile = Join-Path -Path $desktopPath -ChildPath "tor.exe"

# Download the file using Invoke-WebRequest
Invoke-WebRequest -Uri $url -OutFile $outputFile

Write-Host "Downloaded file to: $outputFile"
