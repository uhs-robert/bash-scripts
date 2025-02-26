#!/bin/bash

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

# Extract keybindings from hyprland.conf (updated for 'bindd')
mapfile -t BINDINGS < <(grep '^bindd' "$HYPR_CONF" |
  sed -E 's/bindd[ ]*=[ ]*//g' | awk -F', ' '{print $1 " + " $2 " → " $3 " [" $4 "]"}')

# Debug output
printf '%s\n' "${BINDINGS[@]}" | tee /tmp/hypr_debug.log

# Show in Wofi
CHOICE=$(printf '%s\n' "${BINDINGS[@]}" | wofi --dmenu -i -p "Hyprland Keybinds")

# Extract command from selection
CMD=$(echo "$CHOICE" | awk -F '→ ' '{print $2}' | awk -F ' [' '{print $1}')

# Ensure CMD is not empty
if [[ -z "$CMD" ]]; then
  exit 0
fi

# Execute the selected command
if [[ $CMD == exec* ]]; then
  eval "$CMD"
else
  hyprctl dispatch "$CMD"
fi
