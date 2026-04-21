#!/bin/bash

# ANSI escape codes for terminal colors
RED='\033[0;31m'
NC='\033[0m' # No Color (reset)

# Set the threshold for disk usage alerts
THRESHOLD=80

# Function to check disk usage for all mounted filesystems
check_disk() {
    echo "--- Disk Check ---"
    # Iterate through filesystems, excluding headers
    while read -r line; do
        fs=$(echo "$line" | awk '{print $1}')
        val=$(echo "$line" | awk '{print $5}')
        num=${val//%/} # Remove the '%' sign for numeric comparison
        
        # Compare usage against threshold
        if (( num >= THRESHOLD )); then
            echo -e "FS $fs: ${RED}WARNING: $val${NC}"
        else
            echo "FS $fs: OK ($val)"
        fi
    done < <(df -h | grep "^/")
}

# Function to check RAM usage percentage
check_ram() {
    echo -e "\n--- RAM Check ---"
    # Calculate RAM usage: (Total - Free) / Total * 100
    ram_pct=$(free -m | awk '/Mem:/ {printf "%.0f", ($2-$7)/$2 * 100}')
    
    # Alert if usage exceeds 90%
    if (( ram_pct >= 90 )); then
        echo -e "RAM: ${RED}WARNING: $ram_pct%${NC}"
    else
        echo "RAM: OK ($ram_pct%)"
    fi
}

# Function to check CPU usage
# Note: Requires 'bc' package for floating point arithmetic
check_CPU() {
    echo -e "\n--- CPU Check ---"
    # Sum the CPU percentage of all running processes
    sum=$(ps -eo pcpu --no-headers | awk '{sum+=$1} END {print sum}')
    
    # Calculate average usage per core
    cores=$(nproc)
    cpu_usage=$(echo "scale=0; $sum / $cores" | bc)

    # Alert if usage exceeds 80%
    if (( cpu_usage >= 80 )); then
        echo -e "CPU: ${RED}WARNING: $cpu_usage%${NC}"
    else
        echo "CPU: OK ($cpu_usage%)"
    fi
}

# Execute the checks
check_disk
check_ram
check_CPU