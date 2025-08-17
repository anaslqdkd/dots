#!/usr/bin/env bash

# Usage: ./pywal2nix.sh ~/.cache/wal/colors.json > colorscheme.nix

json="$1"

get() {
  jq -r "$1" "$json"
}

cat <<EOF
{
  colors = {
    primary = {
      background = "$(get '.special.background')";
      foreground = "$(get '.special.foreground')";
    };
    normal = {
      black   = "$(get '.colors.color0')";
      red     = "$(get '.colors.color1')";
      green   = "$(get '.colors.color2')";
      yellow  = "$(get '.colors.color3')";
      blue    = "$(get '.colors.color4')";
      magenta = "$(get '.colors.color5')";
      cyan    = "$(get '.colors.color6')";
      white   = "$(get '.colors.color7')";
    };
    bright = {
      black   = "$(get '.colors.color8')";
      red     = "$(get '.colors.color9')";
      green   = "$(get '.colors.color10')";
      yellow  = "$(get '.colors.color11')";
      blue    = "$(get '.colors.color12')";
      magenta = "$(get '.colors.color13')";
      cyan    = "$(get '.colors.color14')";
      white   = "$(get '.colors.color15')";
    };
  };
}
EOF

