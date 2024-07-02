#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [-u|-d] [-j jump_server] [-i identity_file]"
    echo "  -u: Upload mode (local to remote)"
    echo "  -d: Download mode (remote to local)"
    echo "  -j jump_server: Specify a jump server (optional)"
    echo "  -i identity_file: Specify a private key file (optional)"
    exit 1
}

# Initialize variables
MODE=""
JUMP_SERVER=""
IDENTITY_FILE=""

# Parse command line options
while getopts "udj:i:" opt; do
    case $opt in
        u) MODE="upload" ;;
        d) MODE="download" ;;
        j) JUMP_SERVER="$OPTARG" ;;
        i) IDENTITY_FILE="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check if mode is set
if [ -z "$MODE" ]; then
    echo "Error: Mode (-u or -d) must be specified."
    usage
fi

# Prompt for server details
read -p "Enter remote username: " REMOTE_USER
read -p "Enter remote host (IP or hostname): " REMOTE_HOST

# Construct SCP command
SCP_CMD="scp -r"
if [ -n "$JUMP_SERVER" ]; then
    SCP_CMD="$SCP_CMD -J $JUMP_SERVER"
fi
if [ -n "$IDENTITY_FILE" ]; then
    SCP_CMD="$SCP_CMD -i $IDENTITY_FILE"
fi

# Prompt for paths based on mode
if [ "$MODE" = "upload" ]; then
    read -p "Enter local source path: " SOURCE
    read -p "Enter remote destination path: " DESTINATION
    
    # Perform upload
    $SCP_CMD "$SOURCE" "${REMOTE_USER}@${REMOTE_HOST}:${DESTINATION}"
elif [ "$MODE" = "download" ]; then
    read -p "Enter remote source path: " SOURCE
    read -p "Enter local destination path: " DESTINATION
    
    # Perform download
    $SCP_CMD "${REMOTE_USER}@${REMOTE_HOST}:${SOURCE}" "$DESTINATION"
else
    echo "Error: Invalid mode. This should not happen."
    exit 1
fi

# Check if the scp command was successful
if [ $? -eq 0 ]; then
    echo "Transfer completed successfully."
else
    echo "Transfer failed."
fi