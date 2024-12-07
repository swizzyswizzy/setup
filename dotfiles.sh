#!/bin/bash

echo "copying dotfiles (.config directory) from repository to ~/.config/ directory:"
cp -r ./dotfiles/.config/* ~/.config
cp -r ./dotfiles/homedir/* ~


echo -e "\e[42mSUCCESS\e[0m"
