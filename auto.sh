#!/bin/bash

cd ~/Documents/Automation/
if [[ "$1" == "-p" ]]; then
    if [ -n "$2" ]; then
        git add -A
        git commit -m "$2"
        git push origin main
    else 
        echo "Usage: auto -p <commit message>"
    fi
else
    nvim
    rm -rf ~/Scripts
    cp -r Scripts ~/
fi

