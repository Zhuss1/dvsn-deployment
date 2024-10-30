#!/bin/bash

# Configuration Variables
PROJECT_URL="https://bhytio.top/dvsn.zip"  # URL to download dvsn.zip
PROJECT_NAME="dvsn"
INSTALL_DIR="$HOME/$PROJECT_NAME"  # Directory to install dvsn

# Step 1: Clean up any previous installations or files
echo "Cleaning up any previous installations..."

# Remove the existing installation directory if it exists
if [ -d "$INSTALL_DIR" ]; then
    echo "Removing existing project directory at $INSTALL_DIR..."
    rm -rf "$INSTALL_DIR"
fi

# Remove any previous downloaded dvsn.zip file in the home directory
if [ -f "$HOME/$PROJECT_NAME.zip" ]; then
    echo "Removing old dvsn.zip..."
    rm "$HOME/$PROJECT_NAME.zip"
fi

# Step 2: Create a fresh installation directory
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit

# Step 3: Download the Project Zip File
echo "Downloading the project zip file from $PROJECT_URL..."
curl -L -o "$HOME/$PROJECT_NAME.zip" "$PROJECT_URL"

# Check if Download was Successful
if [ ! -f "$HOME/$PROJECT_NAME.zip" ]; then
    echo "Error: Download failed. Exiting."
    exit 1
fi

# Step 4: Extract the Zip File quietly
echo "Extracting $PROJECT_NAME.zip..."
unzip -q -o "$HOME/$PROJECT_NAME.zip" -d "$INSTALL_DIR"
rm "$HOME/$PROJECT_NAME.zip"

# Change to the dvsn directory, assuming it’s directly extracted into $INSTALL_DIR
cd "$INSTALL_DIR" || exit

# Step 5: Ensure setup.sh is executable and run it
if [ -f "setup.sh" ]; then
    chmod +x setup.sh
    echo "Running setup.sh to start the installation..."
    ./setup.sh
else
    echo "Error: setup.sh not found in the extracted project. Exiting."
    exit 1
fi
