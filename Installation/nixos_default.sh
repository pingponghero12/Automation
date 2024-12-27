#!/bin/bash

set -euo pipefail

error() {
    echo "Error: $1" >&2
    exit 1
}

# Check if root
if [[ $EUID -ne 0 ]]; then
    error "This script requires you to open it with sudo"
fi

# Default disk set to sda
DISK=${1:-/dev/sda}

# Validate disk existence
if [ ! -b "$DISK" ]; then
    error "Disk $DISK does not exist. Please provide a valid disk."
fi

# Confirm disk selection
read -p "Proceed with disk partitioning on $DISK? All data will be lost. (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "Installation aborted."
    exit 1
fi

# Partitioning
echo "Partitioning $DISK...\n"
parted "$DISK" --script -- mklabel msdos
parted "$DISK" --script -- mkpart primary 1MiB -8GiB
parted "$DISK" --script -- set 1 boot on
parted "$DISK" --script -- mkpart primary linux-swap -8GiB 100%

# Formatting
echo "Formatting partitions...\n"
mkfs.ext4 -L nixos "${DISK}1"
mkswap -L swap "${DISK}2"

# Mounting
echo "Mounting root partition...\n"
# I had script stop here for some reason, so we'll double check
mkdir -p /mnt
for x in {1..5}; do
    if mountpoint -q /mnt; then
        break
    fi
    sleep 1
done
mount /dev/disk/by-label/nixos /mnt

echo "Enabling swap...\n"
swapon /dev/disk/by-label/swap

# Generate configuration
echo "Generating NixOS configuration...\n"
nixos-generate-config --root /mnt
sed -i "s|# boot.loader.grub.device = \"/dev/sda\"|boot.loader.grub.device = \"$DISK\"|" /mnt/etc/nixos/configuration.nix

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
