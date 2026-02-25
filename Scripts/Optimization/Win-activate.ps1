# Ensure TLS 1.2+
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Execute the remote script
Invoke-RestMethod "https://get.activated.win" | Invoke-Expression