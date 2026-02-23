#!/usr/bin/env bash

OPTIONS="Enable Mirror\nDisable eDP-1\nEnable eDP-1\nDisable Mirror"
CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Monitor Settings")

case $CHOSEN in
	"Enable Mirror") hyprctl keyword monitor eDP-1,preferred,auto,1,mirror,HDMI-A-1 ;;
	"Disable eDP-1") hyprctl keyword monitor eDP-1,disable ;;
	"Enable eDP-1") hyprctl keyword monitor eDP-1,preferred,-1920x0,1 ;;
	"Disable Mirror") hyprctl keyword monitor eDP-1,disable
		hyprctl keyword monitor eDP-1,preferred,-1920x0,1 
		;;
esac

