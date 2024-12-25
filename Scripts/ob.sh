#!/bin/bash

cd ~/Documents/Obsidian/Obsidian/
if [[ $(ps aux | grep obsidian | wc -l) -le 1 ]]; then
    obsidian > /dev/null 2>&1 &
fi
nvim
