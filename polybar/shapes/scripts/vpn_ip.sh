#!/bin/bash


FILE="$HOME/vpn_ip.txt"

if [[ ! -s $FILE ]]; then
	notify-send "No IP detected"
else
	cat "$FILE" | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'| tr -d '\n' |xclip -sel clip
	notify-send "VPN IP address copied to clipboard"
fi
