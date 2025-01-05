#!/bin/bash

set -e

mkdir -p src include build
touch .gitignore
touch src/main.cpp

cp ~/Scripts/files/CMakeLists.txt ./
cp ~/Scripts/files/startcpp.nix ./shell.nix
nvim ./CMakeLists.txt
