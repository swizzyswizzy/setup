#!/bin/bash

# Variables and directories:
SSH_KEY=~/.ssh/marekzytko_key

# List of packages:
packages=("git" "i3" "curl" "gimp" "chromium" "keepass" "tmux" "zsh" "sl" "ripgrep" "rofi" "tldr")


if [ "$EUID" -eq 0 ]
then echo "Please run as a normal user and input passwords manually each time (because I can't script properely :))))" 
  exit
fi



#						DETERMINING PACKAGE MANAGER
# ----------------------------------------------------------------------------------------------
# https://ilhicas.com/2018/08/08/bash-script-to-install-packages-multiple-os.html

declare -A osInfo;

osInfo[/etc/debian_version]="apt-get install -y"
osInfo[/etc/alpine-release]="apk --update add"
osInfo[/etc/centos-release]="yum install -y"
osInfo[/etc/fedora-release]="dnf install -y"
osInfo[/etc/arch-release]="pacman -Syy"

for f in ${!osInfo[@]};
do
	if [[ -f $f ]];
	then
		PACKAGE_MANAGER=${osInfo[$f]}
		echo Package manager is: \>\> $PACKAGE_MANAGER \<\<\n\n
	fi
done
# ----------------------------------------------------------------------------------------------








#						.SH SCRIPTS
# ----------------------------------------------------------------------------------------------
source dotfiles.sh
source mega.sh
source zsh.sh
# ----------------------------------------------------------------------------------------------




#						INSTALLING PACKAGES
# ----------------------------------------------------------------------------------------------

# Install packages list:
for package in ${packages[@]};
do
	echo -n "Installing ${package}..."
	sudo ${PACKAGE_MANAGER} ${package} > /dev/null
	if [ $? -eq 0 ];
	then
		echo -e "\e[42mSUCCESS\e[0m"
	else
		echo -e "\e[41mFAILED\e[0m"
		${package}
		
	fi
done
# ----------------------------------------------------------------------------------------------








#						SSH SETUP
# ----------------------------------------------------------------------------------------------
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

# ----------------------------------------------------------------------------------------------

