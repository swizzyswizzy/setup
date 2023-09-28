#!/bin/bash

echo "copying files from CONFIG_FILES to repository..."
cp -r ~/CONFIG_FILES/* ~/setup/dotfiles

echo "copying dotfiles (.config directory) from repository to ~/.config/ directory:"
cp -r ./dotfiles/* ~/.config


echo -e "\e[42mSUCCESS\e[0m"
