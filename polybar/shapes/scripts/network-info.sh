#!/bin/sh

RED_TAG="#FF3C3C"
RED_IP="#FF6666"
WHITE="#FFFFFF"
GRAY="#AAAAAA"

STATE_FILE="/tmp/polybar_network_blink.state"

if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi
STATE=$(cat "$STATE_FILE")

if [ "$STATE" -eq 0 ]; then
    ICON="%{F$RED_TAG}●%{F-}"
    echo "1" > "$STATE_FILE"
else
    ICON="%{F$WHITE}●%{F-}" # Color alternativo (blanco)
    echo "0" > "$STATE_FILE"
fi

ETH0_IP=$(ip -4 addr show eth0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
TUN0_IP=$(ip -4 addr show tun0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

echo $ETH0_IP > /tmp/polybar_network_interfaces.tmp
echo $TUN0_IP >> /tmp/polybar_network_interfaces.tmp

if [ -n "$ETH0_IP" ] || [ -n "$TUN0_IP" ]; then
    STATUS="%{F$RED_TAG}[NETWORK]%{F-} %{F$GRAY}::%{F-} %{F$WHITE}ONLINE%{F-}"
else
    STATUS="%{F$RED_TAG}[NETWORK]%{F-} %{F$GRAY}::%{F-} %{F$WHITE}DISCONNECTED%{F-}"
fi

OUTPUT="$ICON $STATUS"

if [ -n "$ETH0_IP" ]; then
    OUTPUT="$OUTPUT %{F$GRAY}::%{F-} %{F$RED_IP}ETH0%{F-} $ETH0_IP"
fi

if [ -n "$TUN0_IP" ]; then
    OUTPUT="$OUTPUT %{F$GRAY}::%{F-} %{F$RED_IP}TUN0%{F-} $TUN0_IP"
fi

echo "$OUTPUT"

