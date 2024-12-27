# Automation
Scripts I use for everyday automation and setting up VMs.

`mvsc.sh` - move `Scripts/` to their place in filesystem. Just one line.

## Scripts
Directory with one file scripts, which help with automation of simple tasks. For all of those I have aliases, which as simple name without `.sh` or `.py`. Scripts are written with intention to alias them as:
```bash
bash <name>.sh
```
and not as `./<name>.sh`, since it allows for creation of temporary bash session, which after end of scipt will return user to normal. That is why I can use `cd` freely in the code.

- `ob.sh` - open nvim in obsidian valut, and if obsidian is not running then run `obsidian`.
- `rebuild.sh` - nvim into `/etc/nixos/` then rebuild NixOS and push to nix-config repository.
- `nixup.sh` - pull from nix-config repository and copy it to `/etc/nixos`
- `oben.sh` - zip obsidian vault, encrypt with `ansible-vault` and push to github repository.
- `obde.sh` - remove current vault, pull vault from github, decrypt and unzip it.
In future I want to also include copying `init.lua` in `rebuild`.

## Setup
Scripts that help with setup on new machine. 
- `git_setup.sh` - script to setup git on new machine. Here main has ssh keys enctypted with `ansible vault`.
- `ubuntu_wm_stup.sh` - old script to setup basic i3wm with tools I use on ubuntu - DEPRECATED

## VM-Instalation
This directory will contain scripts to automate setup of fresh OS instalations or VMs.
