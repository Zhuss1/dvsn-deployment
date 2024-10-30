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
curl -L -o "$PROJECT_NAME.zip" "$PROJECT_URL"

# Check if Download was Successful
if [ ! -f "$PROJECT_NAME.zip" ]; then
    echo "Error: Download failed. Exiting."
    exit 1
fi

# Install Unzip if Not Available
if ! command -v unzip &> /dev/null; then
    echo "Installing unzip..."
    sudo apt update
    sudo apt install -y unzip
fi

# Extract the Zip File
echo "Extracting $PROJECT_NAME.zip..."
unzip -o "$PROJECT_NAME.zip" -d "$INSTALL_DIR"
rm "$PROJECT_NAME.zip"

# Change to the dvsn directory
cd "$INSTALL_DIR/$PROJECT_NAME" || exit

# Ensure setup.sh is executable
chmod +x setup.sh

# Run setup.sh
echo "Running setup.sh to start the installation..."
./setup.sh
