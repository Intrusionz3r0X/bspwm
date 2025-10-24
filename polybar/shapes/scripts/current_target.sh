#!/bin/bash

TARGET_FILE="$HOME/.config/polybar/shapes/scripts/target"

ip_target=$(awk '{print $1}' "$TARGET_FILE")
name_target=$(awk '{print $2}' "$TARGET_FILE")

if [ -n "$ip_target" ] && [ -n "$name_target" ]; then
    echo "%{F#ff0000}$ip_target%{F-} - %{F#ffffff}$name_target%{F-}"
elif [ -n "$ip_target" ]; then
    echo "%{F#ff0000}$ip_target%{F-} - %{F#ffffff}Unknown%{F-}"
else
    echo "%{F#ff0000}No target%{F-}"
fi
