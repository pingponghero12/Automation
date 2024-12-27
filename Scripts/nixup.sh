#!/bin/sh

cd ~/.config/nixos-config

if git pull origin main; then
    sudo cp -r ./nixos/ /etc
fi
