#!/bin/bash
echo -ne "Copying configuration files..."
cp ./dotfiles/wallpaper.jpg ~/.config/i3/
cp ./dotfiles/config ~/.config/i3/
echo -e "\e[42mSUCCESS\e[0m"


