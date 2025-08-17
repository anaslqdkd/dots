#!/usr/bin/env bash
choice=$(printf "Static\nLive" | rofi -dmenu -p "Wallpaper Mode")
if [ "$choice" = "Static" ]; then
	~/.local/bin/set_static.sh
elif [ "$choice" = "Live" ]; then
	~/.local/bin/set_live.sh
fi

