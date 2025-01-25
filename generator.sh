Kommentare bitte in Englisch: #!/bin/bash

generate_password() {
  local length=$1
  local charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
  local password=''
  for ((i=0; i<length; i++)); do
    password+=${charset:$((RANDOM % ${#charset})):1}
  done
  echo "$password"
}

# Überprüfen, ob die Anzahl der Passwörter als Argument übergeben wurde
if [ $# -eq 1 ]; then
  count=\$1
else
  # Anzahl der zu generierenden Passwörter abfragen
  read -p "Wie viele Passwörter sollen generiert werden? " count
fi

# Mindest- und Höchstlänge für Passwörter festlegen
min_length=8
max_length=32

# Länge der Passwörter abfragen
while true; do
  read -p "Wie lang sollen die Passwörter sein? (zwischen $min_length und $max_length Zeichen) " length
  if [[ $length -ge $min_length && $length -le $max_length ]]; then
    break
  else
    echo "Bitte geben Sie eine Länge zwischen $min_length und $max_length Zeichen ein."
  fi
done

# Passwörter generieren und ausgeben
for ((i=1; i<=count; i++)); do
  password=$(generate_password "$length")
  echo "Passwort $i: $password"
  unset password
done

# Passwörter in Datei speichern
read -p "Sollen die Passwörter in einer Datei gespeichert werden? (j/n) " choice
if [[ $choice =~ ^[Jj]$ ]]; then
  read -p "Unter welchem "tag" sollen die Passwörter gespeichert werden? " tag
  filename="password_${tag}_$(date +%Y-%m-%d_%H-%M-%S).txt"
  for ((i=1; i<=count; i++)); do
    password=$(generate_password "$length")
    echo "Passwort $i: $password" >> "$filename"
    unset password
  done
  
  # Verschlüssle und komprimiere die Datei als ZIP-Archiv
  zip -e "${filename%.*}.zip" "$filename"
  
  # Lösche die Originaldatei
  rm "$filename" 2>/dev/null
  
  # Verschiebe das verschlüsselte ZIP-Archiv nach ~/Cred/
  mv "${filename%.*}.zip" ~/Cred/
  
  echo "Passwörter wurden in Datei ${filename%.*}.zip gespeichert und nach ~/Cred/ verschoben."
fi

echo "Fertig!"
