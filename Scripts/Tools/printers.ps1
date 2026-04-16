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
