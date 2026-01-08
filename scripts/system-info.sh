#!/bin/bash
# System Information Script
# Purpose: Collect basic system information for IT Support troubleshooting
# Description: This Bash script gathers basic system and network information commonly requested during Linux troubleshooting.

echo "==== SYSTEM INFORMATION ===="

# Hostname
echo "Hostname: $(hostname)"

# Current User
echo "Current User: $(whoami)"

# Operating System
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "Operating System: $NAME $VERSION"
else
    echo "Operating System: Unknown"
fi

# Uptime
echo "System Uptime:"
uptime -p

# IP Address
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "IP Address: $IP_ADDRESS"

# Disk Space
echo ""
echo "==== DISK SPACE ===="
df -h --total | grep -E "Filesystem|total"

echo ""
echo "==== END OF REPORT ===="
