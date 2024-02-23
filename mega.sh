#!/bin/bash
echo -ne "Installing MegaSync..."

wget https://mega.nz/linux/repo/Arch_Extra/x86_64/megasync-x86_64.pkg.tar.zst && sudo pacman -U megasync-x86_64.pkg.tar.zst && rm megasync-x86_64.pkg.tar.zst

echo -e "\e[42mSUCCESS\e[0m"
