#!/bin/bash

# Prompt the user for the source and destination paths
read -r -p "Enter source directory: " source_dir
read -r -p "Enter destination directory: " dest_dir

# Check if the source directory exists
if [[ ! -d "$source_dir" ]]; then
    echo "Error: The source directory '$source_dir' does not exist."
    exit 1
fi

# Create the destination directory if it doesn't exist
if [[ ! -d "$dest_dir" ]]; then
    echo "Destination directory does not exist. Creating it..."
    mkdir -p "$dest_dir"
fi

# Generate a filename with a timestamp for the backup
timestamp=$(date +%Y%m%d_%H%M)
filename="backup_$timestamp.tar.gz"

echo "Starting compression of '$source_dir' into '$dest_dir/$filename'..."

# Compress the source directory into the destination using tar
tar -czf "$dest_dir/$filename" "$source_dir"

# Verify if the tar command completed successfully (exit code 0)
if [[ $? -eq 0 ]]; then
    echo "Backup completed successfully!"
else
    echo "Error during backup creation."
fi