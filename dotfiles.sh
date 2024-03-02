#!/bin/bash

echo "copying dotfiles (.config directory) from repository to ~/.config/ directory:"
cp -r ./dotfiles/* ~/.config

echo "copying vim configuration file"
cp ./dotfiles/ ~/.vim



cp ./dotfiles/.tmux.conf ~/
cp ./dotfiles/.zshrc ~/



echo -e "\e[42mSUCCESS\e[0m"
