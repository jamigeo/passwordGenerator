# Password Generator Installer

This repository contains a bash script to automatically install a password generator on a Linux Mint system. 

## Features

The password generator has the following features:

- Generates random passwords with a specified number and length of characters
- Optionally saves the generated passwords in a password-protected zip file
- The zip file is saved in the `/Cred` directory with a user-specified tag and date stamp
- When opening the zip file, the user is prompted to enter the password displayed during generation
- Can be added to the Linux Mint panel for one-click password generation when prompted in a web browser
- The panel icon is automatically downloaded and set up by the installer script

## Usage

To download and install, execute the following command in your bash shell:

### wget -O installer.sh https://raw.githubusercontent.com/jamigeo/passwordGenerator/main/installer.sh bash installer.sh

The password generator can then be launched from the application menu. 

When running the generator, you will be prompted to enter:

1. The number of passwords to generate
2. The length of each password 
3. Whether to save the passwords to an encrypted zip file
4. A tag to include in the zip file name

If saving is enabled, the zip file will be created in the `/Cred` directory with a name in the format:

`passwords_<tag>_<YYYY-MM-DD>.zip`

The zip file will be encrypted with a password by generation. When opening the zip file, you will be prompted to enter this password to access the contents.

## Adding to the Linux Mint Panel

To make the most of the password generator, the installer script automatically adds it to the panel of your Linux Mint distribution. This allows you to generate passwords with just one click when prompted in a web browser.

The installer takes care of:

1. Downloading an appropriate icon for the panel launcher
2. Creating a custom application launcher with the correct name and command
3. Adding the launcher to the Linux Mint panel

After installation, you can simply click the "Password Generator" icon in the panel anytime you need to quickly generate secure passwords.
