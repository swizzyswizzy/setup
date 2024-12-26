#!/bin/bash

echo "copying dotfiles (.config directory) from repository to ~/.config/ directory:"
cp -r ./dotfiles/.config/* ~/.config
cp -r ./dotfiles/homedir/* ~

#xorg.conf files
cp -r ./dotfiles/xorg.conf.d/* /etc/X11/xorg.conf.d/


echo -e "\e[42mSUCCESS\e[0m"
