#!/bin/bash

#TODO
#- add parameters (--ssh, --i3, --upgrade, etc.)
#- errors logging





# Variables and directories:
DOT_SSH=~/.ssh
SSH_KEY_NAME=marekzytko_key





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








#						INSTALLING PACKAGES
# ----------------------------------------------------------------------------------------------
# List of packages:
packages=("git" "i3-wm" "neovim" "curl")

# Install packages list:
for package in ${packages[@]};
do
	echo -n "Installing ${package}..."
	${PACKAGE_MANAGER} ${package} > /dev/null
	if [ $? -eq 0 ];
	then
		echo -e "\e[42mSUCCESS\e[0m"
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
eval $(ssh-agent)

# https://stackoverflow.com/questions/43235179/how-to-execute-ssh-keygen-without-prompt
ssh-keygen -q -t rsa -N '' -f $DOT_SSH/$SSH_KEY_NAME <<<y >/dev/null 2>&1
ssh-add $DOT_SSH/$SSH_KEY_NAME 
# ----------------------------------------------------------------------------------------------








#						WINDOWS MANAGER INSTALL (i3)
# ----------------------------------------------------------------------------------------------
# Install windows manager
apt install i3-wm -y


















