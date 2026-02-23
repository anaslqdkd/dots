#!/usr/bin/env bash
current=$(hyprctl monitors -j | jq '.[] | select(.focused==true) | .id')
other=$(hyprctl monitors -j | jq '.[] | select(.focused==false) | .id' | head -n1)
if [ -n "$other" ]; then
  hyprctl dispatch movecurrentworkspacetomonitor "$other"
fi

