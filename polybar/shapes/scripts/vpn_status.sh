#!/bin/sh

IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')

if [ "$IFACE" = "tun0" ]; then
	echo "%{F#ffffff}  %{F#ffffff}$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')%{u-}" | tee vpn_ip.txt
else
	echo "%{F#ffffff} %{u-} Disconnected"
	rm "$HOME/vpn_ip.txt"
fi
