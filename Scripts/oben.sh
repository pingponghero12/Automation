#!/bin/bash

set -e

cd ~/Documents/Obsidian/
rm -f obsidian.zip
zip -r obsidian.zip Obsidian/
ansible-vault encrypt obsidian.zip

git add -A
git commit -m "lalala"
git push origin main
