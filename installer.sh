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

# Icon in ~/.local/share/applications/ ablegen
mv password-IconWhite.svg ~/.local/share/applications/

# --- Desktop-Datei erstellen ---
echo "Erstelle desktop starter..."
cat <<EOF > ~/.local/share/applications/password-generator.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=Passwort Generator
Comment=Generiert sichere Passwörter
Exec=/bin/bash $HOME/.local/share/applications/generator.sh
Icon=$HOME/.local/share/applications/password-IconWhite.svg
Path=
Terminal=true
StartupNotify=false
EOF

# --- Launcher-Integration ---
echo "Versuche Integration in das Panel..."
sudo chmod +x ~/.local/share/applications/password-generator.desktop
echo "Das Installationsskript ist fertig. Der Passwortgenerator wurde installiert."
