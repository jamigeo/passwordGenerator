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

if [ $# -eq 1 ]; then
  count=\$1
else
  read -p "How many passwords should be generated? " count
fi

min_length=8
max_length=32

while true; do
  read -p "How long should the passwords be? (between $min_length and $max_length characters) " length
  if [[ $length -ge $min_length && $length -le $max_length ]]; then
    break
  else
    echo "Please enter a number between $min_length and $max_length characters."
  fi
done

for ((i=1; i<=count; i++)); do
  password=$(generate_password "$length")
  echo "Passwort $i: $password"
  unset password
done

read -p "Should the passwords be saved? (y/n) " choice
if [[ $choice =~ ^[Yy]$ ]]; then
  read -p "With which "tag" should the passwords be saved? " tag
  filename="password_${tag}_$(date +%Y-%m-%d_%H-%M-%S).txt"
  for ((i=1; i<=count; i++)); do
    password=$(generate_password "$length")
    echo "Passwort $i: $password" >> "$filename"
    unset password
  done
  
  zip -e "${filename%.*}.zip" "$filename"

  rm "$filename" 2>/dev/null

  mv "${filename%.*}.zip" ~/Cred/
  echo "Passwords saved in directory Cred"
fi

echo "Ready!"
