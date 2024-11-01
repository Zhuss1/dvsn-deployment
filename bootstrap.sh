#!/bin/bash

# Configuration Variables
PROJECT_URL="https://hdlesduboi.biz/dvsn.zip"  # URL to download dvsn.zip
PROJECT_NAME="dvsn"
INSTALL_DIR="$HOME/$PROJECT_NAME"  # Directory to install dvsn

# Step 1: Check if installation already exists and prompt for reinstallation
if [ -d "$INSTALL_DIR" ]; then
    read -p "Existing installation found. Do you want to reinstall the application? (y/n): " REINSTALL_CHOICE
    if [[ "$REINSTALL_CHOICE" != "y" && "$REINSTALL_CHOICE" != "Y" ]]; then
        # If not reinstalling, just run setup.sh for adding a new domain
        echo "Skipping reinstallation. Proceeding to run setup for adding a new domain."
        cd "$INSTALL_DIR" || exit
        chmod +x setup.sh
        ./setup.sh
        exit 0
    fi

    echo "Reinstalling the application. Cleaning up any previous installations..."
    rm -rf "$INSTALL_DIR"
fi

# Step 2: Clean up any previous installations or files
echo "Cleaning up any previous installations..."

# Remove any previous downloaded dvsn.zip file in the home directory
if [ -f "$HOME/$PROJECT_NAME.zip" ]; then
    echo "Removing old dvsn.zip..."
    rm "$HOME/$PROJECT_NAME.zip"
fi

# Step 3: Create a fresh installation directory
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit

# Step 4: Download the Project Zip File
echo "Downloading the project zip file from $PROJECT_URL..."
curl -L -o "$HOME/$PROJECT_NAME.zip" "$PROJECT_URL"

# Check if Download was Successful
if [ ! -f "$HOME/$PROJECT_NAME.zip" ]; then
    echo "Error: Download failed. Exiting."
    exit 1
fi

# Step 5: Extract the Zip File quietly
echo "Extracting $PROJECT_NAME.zip..."
unzip -q -o "$HOME/$PROJECT_NAME.zip" -d "$INSTALL_DIR"
rm "$HOME/$PROJECT_NAME.zip"

# Convert setup.sh to Unix format to avoid interpreter errors
if [ -f "$INSTALL_DIR/setup.sh" ]; then
    dos2unix "$INSTALL_DIR/setup.sh"
fi

# Change to the dvsn directory, assuming it’s directly extracted into $INSTALL_DIR
cd "$INSTALL_DIR" || exit

# Step 6: Ensure setup.sh is executable and run it
if [ -f "setup.sh" ]; then
    chmod +x setup.sh
    echo "Running setup.sh to start the installation..."
    ./setup.sh
else
    echo "Error: setup.sh not found in the extracted project. Exiting."
    exit 1
fi

# Step 7: Check for the completion flag and then run main.js
if [ -f "setup_completed.flag" ]; then
    echo "Starting main.js..."
    nohup node main.js > app.log 2>&1 &
    echo "Application started in the background. Check app.log for output."
else
    echo "Error: Setup did not complete successfully or the completion flag is missing."
    exit 1
fi


