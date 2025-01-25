#!/bin/bash

generate_password() {
  local length=$1
  local charset='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?'
  local password=''
  for ((i=0; i<length; i++)); do
    password+=${charset:$((RANDOM % ${#charset})):1}
  done
  echo "$password"
}

# Check if the number of passwords was passed as an argument
if [ $# -eq 1 ]; then
  count=\$1
else
  # Ask for the number of passwords to generate
  read -p "How many passwords should be generated? " count
fi

# Set minimum and maximum length for passwords
min_length=8
max_length=32

# Ask for the length of the passwords
while true; do
  read -p "How long should the passwords be? (between $min_length and $max_length characters) " length
  if [[ $length -ge $min_length && $length -le $max_length ]]; then
    break
  else
    echo "Please enter a length between $min_length and $max_length characters."
  fi
done

# Generate and output passwords
for ((i=1; i<=count; i++)); do
  password=$(generate_password "$length")
  echo "Password $i: $password"
  unset password
done

# Save passwords to a file
read -p "Should the passwords be saved in a file? (y/n) " choice
if [[ $choice =~ ^[Yy]$ ]]; then
  read -p "Under which tag should the passwords be saved? " tag
  filename="password_${tag}_$(date +%Y-%m-%d_%H-%M-%S).txt"
  for ((i=1; i<=count; i++)); do
    password=$(generate_password "$length")
    echo "Password $i: $password" >> "$filename"
    unset password
  done
  
  # Encrypt and compress the file as a ZIP archive
  zip -e "${filename%.*}.zip" "$filename"
  
  # Delete the original file
  rm "$filename" 2>/dev/null
  
  # Move the encrypted ZIP archive to ~/Cred/
  mv "${filename%.*}.zip" ~/Cred/
  
  echo "Passwords have been saved in file ${filename%.*}.zip and moved to ~/Cred/."
fi

echo "Done!"
