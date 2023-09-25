#!/bin/bash

#TODO
#- add parameters (--ssh, --i3, --upgrade, etc.)
#- errors logging
#- split sections into seperate files (file for packages, file for ssh, etc)
# if "--option or -all"



# Variables and directories:
SSH_KEY=~/.ssh/marekzytko_key

# List of packages:
packages=("git" "i3-wm" "neovim" "curl" "gimp" "chromium-browser" "keepass2" "tmux" "zsh" "sl" "ripgrep")


if [ "$EUID" -eq 0 ]
then echo "Please run as a normal user."
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
		exit
	fi
done
	

#update & upgrade
#TODO Add different package managers for updating and upgrading distro
#
#apt update -y 
#apt upgrade -y&
#
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



echo -e "\e[42mSETUP SUCCESSFULL !\e[0m"



