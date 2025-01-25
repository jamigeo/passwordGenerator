#!/bin/bash

# --- Vorbereitung ---
echo "System wird aktualisiert..."
sudo apt update && sudo apt upgrade -y

# Unzip wird benötigt, hier sicherstellen, dass es installiert ist
sudo apt install unzip -y

# --- Generator-Skript herunterladen ---
echo "Lade generator.sh herunter..."
wget -O generator.sh https://raw.githubusercontent.com/jamigeo/passwordGenerator/main/generator.sh

# Prüfen, ob der Download erfolgreich war
if [ ! -f "generator.sh" ]; then
  echo "Fehler: generator.sh konnte nicht heruntergeladen werden. Prüfe den Link oder die Internetverbindung."
  exit 1
fi

# Generator-Skript ausführbar machen
chmod +x generator.sh

# Skript in ~/.local/share/applications/ ablegen
echo "Verschiebe generator.sh nach ~/.local/share/applications/..."
mkdir -p ~/.local/share/applications/
mv generator.sh ~/.local/share/applications/

# --- Icon herunterladen ---
echo "Lade password-IconWhite.svg herunter..."
wget -O password-IconWhite.svg https://raw.githubusercontent.com/jamigeo/passwordGenerator/main/password-IconWhite.svg

# Prüfen, ob der Download erfolgreich war
if [ ! -f "password-IconWhite.svg" ]; then
  echo "Fehler: password-IconWhite.svg konnte nicht heruntergeladen werden."
  exit 1
fi

# Icon in ~/.local/share/icons/ ablegen
mkdir -p ~/.local/share/icons/
mv password-IconWhite.svg ~/.local/share/icons/

# --- Desktop-Datei erstellen ---
echo "Erstelle desktop starter..."
printf '%s\n' "[Desktop Entry]
Version=1.0
Type=Application
Name=Passwort Generator
Comment=Generiert sichere Passwörter
Exec=/bin/bash $HOME/.local/share/applications/generator.sh
Icon=$HOME/.local/share/icons/password-IconWhite.svg
Path=
Terminal=true
StartupNotify=false" > ~/.local/share/applications/password-generator.desktop

# Sicherstellen, dass die Desktop-Datei ausführbar ist
chmod +x ~/.local/share/applications/password-generator.desktop

# --- Launcher-Integration ---
echo "Versuche Integration in das Panel..."
if command -v gsettings &> /dev/null; then
    # Herausfinden, welches Desktop-Panel aktiv ist (z. B. GNOME oder Cinnamon)
    PANEL_SCHEMA=$(gsettings list-schemas | grep -E '^org\.gnome\.$shell\|panel\|cinnamon\.panel$')
    
    if [[ $PANEL_SCHEMA == "org.gnome.shell" ]]; then
        # GNOME-Integration, Favoriten hinzufügen
        gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed "s/]$/, 'password-generator.desktop']/")"
        echo "Passwort Generator wurde zu den GNOME-Favoriten hinzugefügt."
        
    elif [[ $PANEL_SCHEMA == "org.cinnamon.panel" ]]; then
        # Cinnamon-Integration (z. B. bei Linux Mint)
        gsettings set org.cinnamon panel-launchers "$(gsettings get org.cinnamon panel-launchers | sed "s/]$/, 'password-generator.desktop']/")"
        echo "Passwort Generator wurde zu den Cinnamon-Panel-Launchern hinzugefügt."
    else
        echo "Panel-Integration nicht automatisch unterstützbar (unbekannte Desktop-Umgebung). Bitte füge die Anwendung manuell zu deinem Panel hinzu."
    fi
else
    echo "gsettings nicht verfügbar. Panel-Integration muss manuell durchgeführt werden."
fi

# --- Skript testen ---
echo "Teste den Passwortgenerator..."
if ! $HOME/.local/share/applications/generator.sh; then
    echo "Fehler: Der Passwortgenerator konnte nicht ausgeführt werden. Bitte überprüfe die Installation."
else
    echo "Der Passwortgenerator wurde erfolgreich getestet."
fi

echo "Das Installationsskript ist fertig. Der Passwortgenerator wurde installiert."
