#!/bin/bash

# Function to handle the termination signal (Ctrl+C)
cleanup() {
    echo -e "\n\nInterrupt signal received. Closing the program..."
    exit 0
}

# Set up the trap to execute the cleanup function on SIGINT
trap cleanup SIGINT

# Save the current directory to return here later
starting_dir=$(pwd)

# Function to generate a system report by calling external monitoring functions
generate_report() {
    # Import monitoring functions
    source ./monitor.sh

    # Append report header to the text file
    echo "==========" >> report_sistema.txt
    echo "SYSTEM REPORT - $(date)" >> report_sistema.txt
    echo "==========" >> report_sistema.txt

    # Execute monitor checks and append output to the report
    check_disk >> report_sistema.txt
    check_CPU >> report_sistema.txt
    check_ram >> report_sistema.txt

    echo "Report generated successfully"
    return
}

# Main menu loop
while true; do
    echo "------------------------------------------------"
    echo "MAIN MENU (Ctrl+C to exit)"
    echo "1: Rename files"
    echo "2: View PC status"
    echo "3: Execute backup"
    echo "4: Generate report"
    echo "------------------------------------------------"

    # Read user input (accepts 1 character)
    read -r -n 1 -p "Insert your choice: " val
    echo "" 

    # Handle user selection
    case "$val" in
        1)
            # Gather inputs for the renaming process
            read -r -p "Insert parameters: " par
            read -r -p "Insert prefix: " pref
            read -r -p "Insert folder (0 for current): " cart
            
            # Logic to handle directory selection
            if [[ "$cart" == "0" ]]; then
                ./rename.sh "$pref"§"$par"
            else
                # Navigate to the folder, run the rename script, then return
                cd "$cart" || { echo "Error: directory not found"; continue; }
                ./rename.sh "$pref"§"$par"
                cd "$starting_dir"
            fi
        ;;
        2)
            # Execute external monitor script
            ./monitor.sh
        ;;
        3)
            # Execute external backup script
            ./backup.sh
        ;;
        4)
            # Call the report generation function
            generate_report
        ;;
        *) 
            # Default case for invalid input
            echo "Invalid option, try again."
        ;;
    esac
done