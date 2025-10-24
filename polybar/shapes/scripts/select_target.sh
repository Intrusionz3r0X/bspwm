#!/bin/bash

TARGET_LIST="$HOME/.config/polybar/shapes/scripts/targets.txt"
SELECTED_FILE="$HOME/.config/polybar/shapes/scripts/target"

if [ ! -s "$TARGET_LIST" ]; then
    notify-send "No targets saved"
    exit 1
fi

SELECTED=$(rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/shapes/scripts/rofi/launcher.rasi -dmenu -p "Select target" < "$TARGET_LIST")

if [ -n "$SELECTED" ]; then
    NAME=$(echo "$SELECTED" | awk '{print $1}')
    IP=$(echo "$SELECTED" | awk '{print $2}')
    echo "$NAME $IP" > "$SELECTED_FILE"
    echo -n "$IP" | xclip -sel clip
    notify-send "Target selected" "$NAME ($IP) copied to clipboard"
fi
