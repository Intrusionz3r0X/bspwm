#!/bin/sh

TARGET_FILE="$HOME/.config/polybar/shapes/scripts/target"

if [ ! -f "$TARGET_FILE" ]; then
    echo "%{F#000000}%{F-} %{F#ffffff}No target%{F-}"
    exit 0
fi

ip_target=$(awk '{print $1}' "$TARGET_FILE")
name_target=$(awk '{print $2}' "$TARGET_FILE")

if [ -n "$ip_target" ] && [ -n "$name_target" ]; then
    echo "%{F#000000}%{F-} %{F#ff0000}$ip_target%{F-} :: %{F#ffffff}$name_target%{F-} :: %{F#00ff00}ACTIVE%{F-}"
elif [ -n "$ip_target" ]; then
    echo "%{F#000000}%{F-} %{F#ff0000}$ip_target%{F-} :: %{F#ffffff}UNKNOWN%{F-}"
else
    echo "%{F#000000}%{F-} %{F#ffffff}No target%{F-}"
fi
