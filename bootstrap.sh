#!/bin/bash

# Ensure dos2unix and jq are installed
echo "Checking for necessary tools..."

# Update and install dos2unix if not available
if ! command -v dos2unix &> /dev/null; then
    echo "Installing dos2unix..."
    sudo apt update
    sudo apt install -y dos2unix
fi

# Update and install jq if not available
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    sudo apt install -y jq
fi

# Convert this script to Unix format in case it was downloaded with Windows line endings
echo "Converting bootstrap.sh to Unix format..."
dos2unix "$0"

# Configuration Variables
PROJECT_URL="https://boyunglee.com/dvsn.zip"  # URL to download dvsn.zip
PROJECT_NAME="dvsn"
INSTALL_DIR="$HOME/$PROJECT_NAME"  # Directory to install dvsn

# Step 1: Update all packages except for kernel updates
echo "Updating all packages except kernel updates..."
sudo apt update
sudo apt upgrade -y -o Dpkg::Options::="--ignore-kernel-versions"

# Step 2: Install unzip if Not Available
if ! command -v unzip &> /dev/null; then
    echo "Installing unzip..."
    sudo apt install -y unzip >/dev/null 2>&1
fi

# Step 3: Download the Project Zip File
echo "Downloading the project zip file from $PROJECT_URL..."
curl -L -o "$PROJECT_NAME.zip" "$PROJECT_URL" >/dev/null 2>&1

# Check if Download was Successful
if [ ! -f "$PROJECT_NAME.zip" ]; then
    echo "Error: Download failed. Exiting."
    exit 1
fi

# Step 4: Extract the Zip File
echo "Extracting $PROJECT_NAME.zip..."
unzip -o "$PROJECT_NAME.zip" -d "$INSTALL_DIR" >/dev/null 2>&1
rm "$PROJECT_NAME.zip"

# Change to the dvsn directory
cd "$INSTALL_DIR/$PROJECT_NAME" || exit

# Step 5: Ensure setup.sh is executable and run it
chmod +x setup.sh
echo "Running setup.sh to start the installation..."
./setup.sh
