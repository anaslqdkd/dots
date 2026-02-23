#!/usr/bin/env bash

OPTIONS=" Lock\n Logout\n⏾ Suspend\n Reboot\n Shutdown"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu")

case $CHOSEN in
    " Lock") hyprctl dispatch exec "swaylock" ;;
    " Logout") hyprctl dispatch exit ;;
    "⏾ Suspend") systemctl suspend ;;
    " Reboot") systemctl reboot ;;
    " Shutdown") systemctl poweroff ;;
esac
