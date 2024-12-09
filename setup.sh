#!/bin/bash

# Variables and directories:
SSH_KEY=~/.ssh/marekzytko_key

# List of packages:
packages=("git" "gimp" "keepass" "tmux" "zsh" "zsh-completions" "ripgrep" "rofi" "tldr" "falkon" "fcron" "openvpn" "alacritty" "btop" "flameshot" "powertop" "xautolock" "playerctl" "dex" "veracrypt" "libinput" "brightnessctl" "ffmpeg" "yubikey-manager-gui" "inetutils" "cpupower" "power-profiles-daemon" "python-gobject" "networkmanager")

yay_packages=("mirage" "corefm" "oh-my-zsh-git" "betterlockscreen" "opera")

if [ "$EUID" -eq 0 ]
then echo "Please run as a normal user and input passwords manually each time (because I can't script properely :))))" 
  exit
fi



#.SH SCRIPTS
source dotfiles.sh
source mega.sh
source zsh.sh
source yay.sh
source zsh.sh



# Install packages list:
for package in ${packages[@]};
do
	echo -n "Installing ${package}..."
	sudo pacman -Syy ${package} --noconfirm > /dev/null
	if [ $? -eq 0 ];
	then
		echo -e "\e[42mSUCCESS\e[0m"
	else
		echo -e "\e[41mFAILED\e[0m"
		${package}
		
	fi
done


# Install packages list:
for package in ${yay_packages[@]};
do
	echo -n "Installing ${package}..."
	yay ${package} --noconfirm > /dev/null
	if [ $? -eq 0 ];
	then
		echo -e "\e[42mSUCCESS\e[0m"
	else
		echo -e "\e[41mFAILED\e[0m"
		${package}
		
	fi
done


# SSH SETUP
# Setup ssh-agent and generate ssh key
echo -n "starting SSH agent..." 
eval $(ssh-agent) > /dev/null

if [ $? -eq 0 ];
then
	echo -e "\e[42mSUCCESS\e[0m"
fi

echo -n "generating SSH key..."
# https://stackoverflow.com/questions/43235179/how-to-execute-ssh-keygen-without-prompt
ssh-keygen -q -t rsa -N '' -f $SSH_KEY<<<y >/dev/null
echo -e "\e[42mSUCCESS\e[0m"


echo -n "adding SSH key to agent..."
ssh-add $SSH_KEY > /dev/null
echo -e "\e[42mSUCCESS\e[0m"





# Additional configuration commands:
echo -n "setting vim as a global git editor..."
git config --global core.editor vim

# Set crontab
echo -n "installing crontab..."
sudo fcrontab dotfiles/crontab.crontab

