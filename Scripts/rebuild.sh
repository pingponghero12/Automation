#!/bin/sh

set -e

if [[ $1 != "-v" ]]; then
    sudo nvim /etc/nixos/
    cd ~/.config/nixos-config
    if sudo nixos-rebuild switch --flake /etc/nixos#hostname; then
        sudo rm -rf ./nixos
        sudo cp -r /etc/nixos ./

        git add -A
        git commit -m "Hello"
        git push origin main
    fi
else
    nvim /etc/nixos/
fi
