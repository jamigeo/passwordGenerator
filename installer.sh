#!/bin/bash

# updating the system
sudo apt update && sudo apt upgrade -y

# install unzip if not already installed
sudo apt install unzip -y

# Create necessary directories
mkdir -p ~/.local/share/applications
mkdir -p ~/Cred

# Define the base URL for raw GitHub content
BASE_URL="https://raw.githubusercontent.com/jamigeo/passwordGenerator/main"

# download generator.sh
wget -O ~/.local/share/applications/generator.sh "${BASE_URL}/generator.sh"

# make the script generator.sh executable
chmod +x ~/.local/share/applications/generator.sh

# download the icon
wget -O ~/.local/share/applications/password-IconWhite.svg "${BASE_URL}/password-IconWhite.svg"

# setup the desktop entry
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Passwort Generator
Comment=Generiert sichere Passwörter
Exec=${HOME}/.local/share/applications/generator.sh
Icon=${HOME}/.local/share/applications/password-IconWhite.svg
Path=
Terminal=true
StartupNotify=false" > ~/.local/share/applications/password-generator.desktop

# Make the desktop entry executable
chmod +x ~/.local/share/applications/password-generator.desktop

echo "Installation abgeschlossen!"
