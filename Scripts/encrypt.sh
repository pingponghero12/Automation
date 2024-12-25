#!/bin/bash

cd ~/Documents/Obsidian/
rm obsidian.zip
zip -r obsidian.zip Obsidian/
ansible-vault encrypt obsidian.zip

git add -A
git commit -m "lalala"
git push origin main
