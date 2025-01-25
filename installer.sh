#!/bin/bash

# updating the system
sudo apt update && sudo apt upgrade -y

# install unzip if not already installed
sudo apt install unzip -y

# download generator.sh
wget https://github.com/jamigeo/passwordGenerator.git/generator.sh

# make the script generator.sh executable
chmod +x generator.sh

# move generator.sh to /usr/local/bin/
sudo mv generator.sh ~/.local/share/applications/generator.sh

# download the icon
wget https://github.com/jamigeo/passwordGenerator.git/password-IconWhite.svg

# move the icon to /usr/share/icons/
sudo mv password-IconWhite.svg ~/.local/share/applications/password-IconWhite.svg

# setup the desktop
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Passwort Generator
Comment=Generiert sichere Passwörter
Exec=~/.local/share/applications/generator.sh
Icon=/.local/share/applications/password-IconWhite.svg
Path=
Terminal=true
StartupNotify=false" > ~/.local/share/applications/password-generator.desktop
