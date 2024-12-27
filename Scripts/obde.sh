#!/bin/bash

cd ~/Documents/Obsidian/
rm -rf ~/Documents/Obsidian/Obsidian/
git reset --hard
if git pull --rebase origin main; then
    ansible-vault decrypt obsidian.zip
    unzip obsidian.zip
else
    echo "Pull failed."
fi
