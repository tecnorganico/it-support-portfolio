#!/bin/bash
# macOS System Information Script
# Purpose: Collect basic system information for IT Support troubleshooting
# 

echo "==== SYSTEM INFORMATION ===="

# Computer Name
echo "Computer Name: $(scutil --get ComputerName)"

# Current User
echo "Current User: $(whoami)"

# Operating System
OS_VERSION=$(sw_vers -productVersion)
echo "macOS Version: $OS_VERSION"

# Uptime
echo "System Uptime:"
uptime

# IP Address (Wi-Fi)
IP_ADDRESS=$(ipconfig getifaddr en0 2>/dev/null)
if [ -z "$IP_ADDRESS" ]; then
    echo "IP Address: Not connected"
else
    echo "IP Address: $IP_ADDRESS"
fi

# Disk Space
echo ""
echo "==== DISK SPACE ===="
df -h /

echo ""
echo "==== END OF REPORT ===="
