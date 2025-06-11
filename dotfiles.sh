#!/bin/bash

echo "copying dotfiles (.config directory) from repository to ~/.config/ directory:"
mkdir -p ~/.config
cp -r ./dotfiles/.config/* ~/.config
cp -r ./dotfiles/homedir/* ~
cp -r ./dotfiles/homedir/.vimrc ~
cp -r ./dotfiles/homedir/.zshrc ~

cp -r ./dotfiles/homedir/autoload ~/.vim
cp -r ./dotfiles/homedir/colors ~/.vim

#xorg.conf files
cp -r ./dotfiles/xorg.conf.d/* /etc/X11/xorg.conf.d/


echo -e "\e[42mSUCCESS\e[0m"
