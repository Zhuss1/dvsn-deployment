#!/bin/bash

# Configuration Variables
PROJECT_URL="https://hdlesduboi.biz/dvsn.zip"  # URL to download dvsn.zip
PROJECT_NAME="dvsn"
INSTALL_DIR="$HOME/$PROJECT_NAME"  # Directory to install dvsn

# Download the project zip file
echo "Downloading the project zip file from $PROJECT_URL..."
curl -L -o "$HOME/$PROJECT_NAME.zip" "$PROJECT_URL"

# Verify download success
if [ $? -ne 0 ] || [ ! -f "$HOME/$PROJECT_NAME.zip" ]; then
    echo "Error: Download failed or file not found. Exiting."
    exit 1
fi
