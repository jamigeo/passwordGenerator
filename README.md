# Password Generator Installer

This repository contains a bash script to automatically install a password generator on a Linux Mint system. 

## Features

The password generator has the following features:

- Generates random passwords with a specified number and length of characters
- Optionally saves the generated passwords in a password-protected zip file
- The zip file is saved in the `/Cred` directory with a user-specified tag and date stamp
- When opening the zip file, the user is prompted to enter the password displayed during generation
- Can be added to the Linux Mint panel for one-click password generation when prompted in a web browser

## Usage

To install the password generator, execute the following command in a terminal:

[`wget -O - https://github.com/jamigeo/passwordGenerator.git/installer.sh | bash`](https://github.com/jamigeo/passwordGenerator.git/installer.sh)

The password generator can then be launched from the application menu. 

When running the generator, you will be prompted to enter:

1. The number of passwords to generate
2. The length of each password 
3. Whether to save the passwords to an encrypted zip file
4. A tag to include in the zip file name

If saving is enabled, the zip file will be created in the `/Cred` directory with a name in the format:

`passwords_<tag>_<YYYY-MM-DD>.zip`

You will be prompted for a password by creation of the *.zip file...

## Adding to the Linux Mint Panel

To make the most of the password generator, you should add it to the panel of your Linux Mint distribution. This will allow you to generate passwords with just one click when prompted in a web browser.

To add the generator to the panel:

1. Right-click on the panel and select "Add to Panel"
2. Choose "Custom Application Launcher" and click "Add" 
3. Set the "Name" to "Password Generator"
4. Set the "Command" to the path of the installed password generator script
5. Click "OK" to add the launcher to the panel

Now you can simply click the "Password Generator" icon in the panel anytime you need to quickly generate secure passwords.
