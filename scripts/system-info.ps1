# System Information Script
# Purpose: Collect basic system information for IT Support troubleshooting
# Description: It collects basic system information that is commonly requested during IT support troubleshooting, such as OS version, uptime, IP address, and disk space. This helps speed up diagnosis and documentation.

Write-Host "==== SYSTEM INFORMATION ===="

# Hostname
$hostname = $env:COMPUTERNAME
Write-Host "Computer Name: $hostname"

# Current User
$user = $env:USERNAME
Write-Host "Current User: $user"

# Operating System
$os = Get-CimInstance Win32_OperatingSystem
Write-Host "Operating System: $($os.Caption)"
Write-Host "OS Version: $($os.Version)"

# System Uptime
$uptime = (Get-Date) - $os.LastBootUpTime
Write-Host "System Uptime: $($uptime.Days) days, $($uptime.Hours) hours"

# IP Address
$ip = Get-NetIPAddress -AddressFamily IPv4 |
      Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } |
      Select-Object -First 1 -ExpandProperty IPAddress
Write-Host "IP Address: $ip"

# Disk Space
Write-Host "`n==== DISK SPACE ===="
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
ForEach-Object {
    $freeGB = [math]::Round($_.FreeSpace / 1GB, 2)
    $totalGB = [math]::Round($_.Size / 1GB, 2)
    Write-Host "Drive $($_.DeviceID): $freeGB GB free of $totalGB GB"
}

Write-Host "`n==== END OF REPORT ===="
