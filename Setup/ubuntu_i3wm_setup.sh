#!/bin/bash

set -e  # Stop script on any errors

# Get scripts local path
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Enusure paths exist
mkdir -p ~/scripts ~/.config/i3

# Update apt and update system
sudo apt update && sudo apt upgrade -y

# Ensure vim installed
sudo apt install -y vim

# Ensure firewall enabled
sudo ufw enable

# Enable and start SSH
sudo systemctl enable ssh
sudo systemctl start ssh

# Configure proper time
read -p "Enter your timezone (e.g., Europe/Kiev): " tz
sudo timedatectl set-timezone "$tz"

# Setup of .bashrc
grep -qxF "export TZ=${tz}" ~/.bashrc || echo 'export TZ="Europe/Kiev"' >> ~/.bashrc
grep -qxF "alias ob='source ~/scripts/ob.sh'" ~/.bashrc || echo "alias ob='source ~/scripts/ob.sh'" >> ~/.bashrc
grep -qxF "alias xcp='xclip -sel c <'" ~/.bashrc || echo "alias xcp='xclip -sel c <'" >> ~/.bashrc

# Add scripts and ob.sh
cp "${script_dir}/files/ob.sh" ~/scripts

# Install packages required for i3
sudo apt install -y xorg i4 rxvt-unicode xfce4-terminal net-tools htop openssh-server xinit

# Setup startx
echo > ~/.xinitrc "exec i3"

# Install system valuable
sudo apt install -y firefox thunar blueman ansible ansible-vault xclip

# Install vscode(bleh)
sudo mv /etc/apt/preferences.d/nosnap.pref ~/Documents/nosnap.backup
sudo apt install -y snapd
sudo snap install --classic code

# Install Obsidian
sudo snap install obsidian --classic --dangerous

# Move i3 config
cp "${script_dir}/files/i3_config" ~/.config/i3/config

# Setup mouse Acc
cp "${script_dir}/files/mouse_config" /etc/X11/xorg.conf.d/99-libinput-custom-config.conf

# Setup theme color related
sudo apt install -y arc-theme qt5ct
echo 'gtk-theme-name="Adwaita-dark"' > ~/.gtkrc-2.0
echo -e "[Settings]\ngtk-theme-name=Adwaita-dark" > ~/.config/gtk-3.0/settings.ini

echo "You need to change qt5ct theme, use 'qt5ct'"
echo "Basic setup completed. Reboot and start i3 by 'startx'. If you have lightDM installed, you just need to select i3wm there."
echo "Current time $(date)"

