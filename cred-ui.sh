#!/usr/bin/env bash

ROFI_CMD="rofi -no-config -no-lazy-grab -dmenu -i -theme ~/.config/polybar/shapes/scripts/rofi/launcher.rasi"
STORE="$HOME/.password-store/creds"

[ ! -d "$STORE" ] && notify-send "Creds" "No credential store found" && exit 1

# 1. Select client
CLIENT=$(find "$STORE" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" \
  | sort \
  | $ROFI_CMD -p "Client")

[ -z "$CLIENT" ] && exit 0

# 2. Select credential (domain/account)
CRED=$(find "$STORE/$CLIENT" -type f -name "*.gpg" \
  | sed "s|$STORE/$CLIENT/||;s|\.gpg$||" \
  | sort \
  | $ROFI_CMD -p "$CLIENT")

[ -z "$CRED" ] && exit 0

FULL_PATH="creds/$CLIENT/$CRED"

# 3. Select action
ACTION=$(printf "Copy username\nCopy password\n" | $ROFI_CMD -p "$CRED")
[ -z "$ACTION" ] && exit 0

case "$ACTION" in
  "Copy username")
    pass show "$FULL_PATH" | sed -n '2p' | tr -d '\n' | xclip -selection clipboard
    notify-send "Creds" "Username copied"
    ;;
  "Copy password")
    pass show "$FULL_PATH" | head -n1 | tr -d '\n' | xclip -selection clipboard
    notify-send "Creds" "Password copied (15s)"
    (
      sleep 15
      xclip -selection clipboard </dev/null
      notify-send "Creds" "Clipboard cleared"
    ) &
    ;;
esac
