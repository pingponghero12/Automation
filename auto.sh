#!/bin/bash

set -e

cd ~/Documents/Automation/
if [[ "$1" == "-p" ]]; then
    if [ -n "$2" ]; then
        git add -A
        git commit -m "$2"
        git push origin main
    else 
        echo "Usage: auto -p <commit message>"
    fi
elif [[ "$1" == "-s" ]]; then
    git status
elif [[ "$1" == "--pull" ]]; then
    git pull origin main
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: auto [PARAMETERS]"
    echo
    echo "Options:"
    echo "  -p <message>    Adds all changes, commits with the specified message, and pushes to origin main"
    echo "                  Example: auto -p \"Add new feature\""
    echo
    echo "  -s              Shows git status of the current repository"
    echo
    echo "  --pull          Pulls latest changes from origin main"
    echo
    echo "  --help, -h       Displays this help message"
    echo
    echo "Running without options will:"
    echo "  1. Open nvim editor"
    echo "  2. Remove ~/Scripts directory (if it exists)"
    echo "  3. Copy Scripts directory to home folder"
    echo
    echo "Current auto directory: $(pwd)"
    echo
else
    nvim
    rm -rf ~/Scripts
    cp -r Scripts ~/
fi

