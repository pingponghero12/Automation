#!/bin/bash

set -euo pipefail

sudo -i

# Default disk set to sda
DISK=${1:-/dev/sda}

# Confirm disk selection
read -p "Proceed with disk partitioning on $DISK? All data will be lost. (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

# Partitioning
echo "Partitioning $DISK...\n"
parted "$DISK" --script -- mklabel msdos
parted "$DISK" -- script -- mkpart primary 1MiB -8GiB
parted "$DISK" -- script -- set 1 boot on
parted "$DISK" -- script -- mkpart primary linux-swap -8GiB 100%

# Formatting
echo "Formatting partitions...\n"
mkfs.ext4 -L nixos "${DISK}1"
mkswap -L swap "${DISK}2"

# Mounting
echo "Mounting root partition...\n"
mount /dev/disk/by-label/nixos /mnt

echo "Enabling swap...\n"
swapon /dev/disk/by-label/swap

# Generate configuration
echo "Generating NixOS configuration...\n"
nixos-generate-config --root /mnt

# Change configuration
read -p "Do you want to edit the configuration? (y/N): " edit_conf
if [[ $edit_conf =~ ^[Yy]$ ]]; then
    vim "/mnt/etc/nixos/configuration.nix"
fi

# Installation
echo "Starting NixOS installation...\n"
nixos-install

echo "Installation complete. If you added user you can now change its password using:"
echo "nixos-enter --root /mnt -c 'passwd <user_name>'\n"
echo "You can now reboot."
