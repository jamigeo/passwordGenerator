#!/bin/bash

# --- Preparation ---
echo "System is being updated..."
sudo apt update && sudo apt upgrade -y

# Unzip is needed, ensure it is installed
sudo apt install unzip -y

# --- Download generator script ---
echo "Downloading generator.sh..."
wget -O generator.sh https://raw.githubusercontent.com/jamigeo/passwordGenerator/main/generator.sh

# Check if the download was successful
if [ ! -f "generator.sh" ]; then
  echo "Error: generator.sh could not be downloaded. Check the link or your internet connection."
  exit 1
fi

# Make the generator script executable
chmod +x generator.sh

# Move the script to ~/.local/share/applications/
echo "Moving generator.sh to ~/.local/share/applications/..."
mkdir -p ~/.local/share/applications/
mv generator.sh ~/.local/share/applications/

# --- Download icon ---
echo "Downloading password-IconWhite.svg..."
wget -O password-IconWhite.svg https://raw.githubusercontent.com/jamigeo/passwordGenerator/main/password-IconWhite.svg

# Check if the download was successful
if [ ! -f "password-IconWhite.svg" ]; then
  echo "Error: password-IconWhite.svg could not be downloaded."
  exit 1
fi

# Move icon to ~/.local/share/icons/
mkdir -p ~/.local/share/icons/
mv password-IconWhite.svg ~/.local/share/icons/

# --- Create desktop file ---
echo "Creating desktop starter..."
printf '%s\n' "[Desktop Entry]
Version=1.0
Type=Application
Name=Generator
Comment=Generates secure passwords
Exec=/bin/bash $HOME/.local/share/applications/generator.sh
Icon=$HOME/.local/share/icons/password-IconWhite.svg
Path=
Terminal=true
StartupNotify=false" > ~/.local/share/applications/Generator.desktop

# Ensure the desktop file is executable
chmod +x ~/.local/share/applications/Generator.desktop

# --- Launcher integration ---
echo "Attempting panel integration..."
if command -v gsettings &> /dev/null; then
    # Determine which desktop panel is active (e.g., GNOME or Cinnamon)
    PANEL_SCHEMA=$(gsettings list-schemas | grep -E '^org\.gnome\.(shell|panel|cinnamon\.panel)$')
    
    if [[ $PANEL_SCHEMA == "org.gnome.shell" ]]; then
        # GNOME integration, add to favorites
        gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed "s/]$/, 'Generator.desktop']/")"
        echo "Password Generator has been added to GNOME favorites."
        
    elif [[ $PANEL_SCHEMA == "org.cinnamon.panel" ]]; then
        # Cinnamon integration (e.g., for Linux Mint)
        gsettings set org.cinnamon panel-launchers "$(gsettings get org.cinnamon panel-launchers | sed "s/]$/, 'Generator.desktop']/")"
        echo "Password Generator has been added to Cinnamon panel launchers."
    else
        echo "Panel integration not automatically supported (unknown desktop environment). Please add the application to your panel manually."
    fi
else
    echo "gsettings not available. Panel integration must be done manually."
fi

# --- Test script ---
echo "Testing the password generator..."
echo ""
echo ""
if ! $HOME/.local/share/applications/generator.sh; then
    echo "Error: The password generator could not be executed. Please check the installation."
else
    echo "The password generator was successfully tested."
fi

echo "The installation script is complete. The password generator has been installed. If the Generator isn't added to your panel, then you can add the 'Generator' by searching it in the system, and with rightclick you can add it to..."
