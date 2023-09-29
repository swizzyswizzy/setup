#!/bin/bash
#TODO
#- add parameters (--ssh, --i3, --upgrade, etc.)
#- errors logging
#- split sections into seperate files (file for packages, file for ssh, etc)
# if "--option or -all"
echo -ne "Installing MegaSync..."

wget https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megasync-xUbuntu_22.04_amd64.deb
sudo apt install -y "$PWD/megasync-xUbuntu_22.04_amd64.deb"

echo -e "\e[42mSUCCESS\e[0m"
