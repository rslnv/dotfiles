#!/bin/bash

labels=(
  "󰐥 Power off"
  "󰜉 Reboot"
  "󰍃 Logout"
  "󰒲 Sleep"
  "󰌾 Lock"
)

commands=(
  "systemctl poweroff"
  "systemctl reboot"
  "swaymsg exit"
  "systemctl suspend"
  "swaylock -f"
)

lines=${#commands[@]}

selected=$(printf '%s\n' "${labels[@]}" | rofi -dmenu -i -matching fuzzy -p Exit -format i -theme-str "#window { width: 180px; } #listview { scrollbar: false; lines: $lines; }")

[[ -n "$selected" ]] && ${commands[$selected]}
