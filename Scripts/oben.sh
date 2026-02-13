#!/bin/bash

set -e

cd ~/Documents/Obsidian/
rm -f obsidian.zip
zip -r obsidian.zip Obsidian/
ansible-vault encrypt obsidian.zip

git add -A
git commit -m "Automated commit with obsidian encrypt command."
git push origin main
