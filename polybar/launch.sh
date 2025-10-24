#!/usr/bin/env bash
# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/shapes"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Count connected monitors
monitors=$(xrandr --query | grep -c " connected")


# Launch the bar
if [ "$monitors" -eq 1 ]; then
    polybar -q workspace -c "$DIR"/config.ini &
    polybar -q logo -c "$DIR"/config.ini &
    polybar -q targeticon -c "$DIR"/config.ini &
    polybar -q target -c "$DIR"/config.ini &
    polybar -q network -c "$DIR"/config.ini &
    polybar -q centertop -c "$DIR"/config.ini &
    
else
    # If multiple monitors, launch one for each
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar -q workspace -c "$DIR"/config.ini &
	MONITOR=$m polybar -q logo -c "$DIR"/config.ini &
	MONITOR=$m polybar -q targeticon -c "$DIR"/config.ini &
        MONITOR=$m polybar -q target -c "$DIR"/config.ini &
	MONITOR=$m polybar -q network -c "$DIR"/config.ini &
	MONITOR=$m polybar -q centertop -c "$DIR"/config.ini &
    done
fi
