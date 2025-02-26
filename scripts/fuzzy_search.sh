#!/bin/bash

# Define user preferences
TERMINAL=kitty
LOCATIONS=(/ ~ ~/Documents ~/Documents/github-uphill)

# Collect only first-level directories, explicitly including `~`
FOLDERS=$(
  echo ~
  for loc in "${LOCATIONS[@]}"; do
    find "$loc" -maxdepth 1 -mindepth 1 -type d ! -name ".git" ! -name "node_modules" ! -name ".cache"
  done
)

# Let user select a directory with Wofi
SEARCH_DIR=$(echo "$FOLDERS" | wofi --dmenu -i -p "Select Directory")

# If a directory was selected, open a terminal and run fzf inside it
if [[ -n "$SEARCH_DIR" ]]; then
  $TERMINAL -e bash -c "fd . \"$SEARCH_DIR\" --exclude '.git' --exclude 'node_modules' --exclude '.cache' | fzf --preview 'bat --color=always --style=plain {}' --ansi | xargs -r xdg-open"
fi
