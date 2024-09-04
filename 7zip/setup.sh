#!/bin/bash

sudo apt install p7zip-full

script_directory=$(dirname "$0")

file_path="$script_directory/zip-fns.sh"

cat "$file_path" >> ~/.zshrc

echo "Zip function added to ~/.zshrc. You may need to restart your shell for the changes to take effect."

source ~/.zshrc
