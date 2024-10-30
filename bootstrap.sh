#!/bin/bash

# Configuration Variables
PROJECT_URL="https://boyunglee.com/dvsn.zip"  # URL to download dvsn.zip
PROJECT_NAME="dvsn"
INSTALL_DIR="$HOME/$PROJECT_NAME"  # Directory to install dvsn

# Create Installation Directory
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit

# Download the Project Zip File
echo "Downloading the project zip file from $PROJECT_URL..."
curl -L -o "$PROJECT_NAME.zip" "$PROJECT_URL" >/dev/null 2>&1

# Check if Download was Successful
if [ ! -f "$PROJECT_NAME.zip" ]; then
    echo "Error: Download failed. Exiting."
    exit 1
fi

# Install Dependencies if Not Available
if ! command -v unzip &> /dev/null; then
    echo "Installing unzip..."
    sudo apt update >/dev/null 2>&1
    sudo apt install -y unzip >/dev/null 2>&1
fi

# Install jq for JSON parsing with output visible
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    sudo apt update && sudo apt install -y jq
fi

# Extract the Zip File
echo "Extracting $PROJECT_NAME.zip..."
unzip -o "$PROJECT_NAME.zip" -d "$INSTALL_DIR" >/dev/null 2>&1
rm "$PROJECT_NAME.zip"

# Change to the dvsn directory
cd "$INSTALL_DIR/$PROJECT_NAME" || exit

# Ensure setup.sh is executable
chmod +x setup.sh

# Run setup.sh
echo "Running setup.sh to start the installation..."
./setup.sh
