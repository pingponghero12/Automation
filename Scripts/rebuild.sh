#!/bin/sh

sudo nvim /etc/nixos/

if sudo nixos-rebuild switch --flake /etc/nixos#hostname; then
    cd ~/.config/nixos-config

    rm -rf ./nixos
    sudo cp -r /etc/nixos ./nixos/

    git add -A
    git commit -m "Hello"
    git push origin main
fi



