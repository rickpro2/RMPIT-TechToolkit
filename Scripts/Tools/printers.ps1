<#

# 1. Get user input for IP address and Display Name
$PrinterIP = Read-Host -Prompt "Enter the printer's IP address"
$DisplayName = Read-Host -Prompt "Enter the name you want displayed for this printer"

# 2. Define the Driver Name (Replace with your specific driver name)
# Example: "Generic / Text Only" or "HP Universal Printing PCL 6"
$DriverName = "Generic / Text Only"

# 3. Create the Standard TCP/IP Printer Port
# Using the IP address as the port name is standard practice
Add-PrinterPort -Name $PrinterIP -PrinterHostAddress $PrinterIP

# 4. Add the Printer to the system
Add-Printer -Name $DisplayName -DriverName $DriverName -PortName $PrinterIP

Write-Host "Successfully added printer: $DisplayName at $PrinterIP" -ForegroundColor Green
#>

# 1. Gather User Input for IP and Name
$PrinterIP = Read-Host -Prompt "Enter the Printer's IP Address"
$PrinterName = Read-Host -Prompt "Enter the Display Name for this printer"

# 2. Get list of installed drivers and present a selection menu
$Drivers = Get-PrinterDriver | Select-Object -ExpandProperty Name | Sort-Object -Unique
Write-Host "`nAvailable Printer Drivers:" -ForegroundColor Cyan
for ($i=0; $i -lt $Drivers.Count; $i++) {
    Write-Host "[$i] $($Drivers[$i])"
}

$Selection = Read-Host -Prompt "Enter the number of the driver you want to use"
$SelectedDriver = $Drivers[$Selection]

# 3. Create the Printer Port (TCP/IP)
Write-Host "Creating printer port for $PrinterIP..." -ForegroundColor Yellow
Add-PrinterPort -Name "$PrinterIP" -PrinterHostAddress "$PrinterIP"

# 4. Add the Printer
Write-Host "Adding printer: $PrinterName using driver: $SelectedDriver..." -ForegroundColor Yellow
Add-Printer -Name "$PrinterName" -DriverName "$SelectedDriver" -PortName "$PrinterIP"

Write-Host "Printer successfully added!" -ForegroundColor Green
