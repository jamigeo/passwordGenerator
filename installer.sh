#!/bin/bash

# updating the system
sudo apt update && sudo apt upgrade -y

# install unzip if not already installed
sudo apt install unzip -y

# download generator.sh
wget https://raw.githubusercontent.com/username/passwort-generator-installer/main/generator.sh

# make the script generator.sh executable
chmod +x generator.sh

# move generator.sh to /usr/local/bin/
sudo mv generator.sh /usr/local/bin/passwort-generator

# setup the desktop
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Passwort Generator
Comment=Generiert sichere Passwörter
Exec=/usr/local/bin/passwort-generator
Icon=utilities-terminal
Path=
Terminal=true
StartupNotify=false" > ~/.local/share/applications/passwort-generator.desktop

