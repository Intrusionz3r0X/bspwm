#!/bin/bash

CRED_FILE="$HOME/.config/polybar/shapes/scripts/credentials.txt"

if [ ! -s "$CRED_FILE" ]; then
    notify-send "No credentials saved"
    exit 1
fi

SELECTED=$(rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/shapes/scripts/rofi/launcher.rasi -dmenu -p "Select credentials" < "$CRED_FILE")

if [ -n "$SELECTED" ]; then
    echo -n "$SELECTED" | xclip -selection clipboard
    notify-send "Credentials copied to clipboard"
fi
