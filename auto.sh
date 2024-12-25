#!/bin/bash

cd ~/Documents/Automation/
if [[ "$1" == "-p" ]]; then
    git add -A
    git commit -m "$2"
    git push origin main
else
    nvim
    rm -rf ~/Scripts
    cp -r Scripts ~/
fi

