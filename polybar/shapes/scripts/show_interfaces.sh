#!/bin/bash
IP_SELECTED=$(rofi -no-config -no-lazy-grab -theme ~/.config/polybar/shapes/scripts/rofi/launcher.rasi -dmenu -p "Select interface" < /tmp/polybar_network_interfaces.tmp)
if ! [[ "$IP_SELECTED" == "" ]];then
	echo -n $IP_SELECTED | xclip -sel clip
	notify-send "($IP_SELECTED) copied to clipboard"
else
	echo -n "Not IP selected."
fi


