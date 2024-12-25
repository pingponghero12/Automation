#!/bin/sh

sudo nvim /etc/nixos/
sudo nixos-rebuild switch --flake /etc/nixos#hostname
