#!/bin/bash

FILE="$HOME/ethernet_ip.txt"

if [[ ! -s $FILE ]];then
	notify-send "Not IP detected"
else
	cat "$FILE" | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'| tr -d '\n' |xclip -sel clip
	notify-send "IP address copied to clipboard"
fi
