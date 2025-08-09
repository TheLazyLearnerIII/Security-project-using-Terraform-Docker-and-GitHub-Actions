#!/bin/bash
set -e

# Make sure logs directory exists
mkdir -p /var/log/lynis-scan

# Go to Lynis directory
cd /opt/lynis

# Run scan and write to mounted log file
./lynis audit system | tee /var/log/lynis-scan/scan.log

# Print out success message 
echo "Lynis scan complete. Output saved to /var/log/lynis-scan/scan.log"

# If the script completes successfully
exit 0

