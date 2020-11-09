#!/bin/bash

poweroff_command="systemctl poweroff"
reboot_command="systemctl reboot"
logout_command="swaymsg exit"
sleep_command="systemctl suspend"

rofi_command='wofi --dmenu --prompt Exit --width 10 --hide-scroll --insensitive'

options=$'Power Off\nReboot\nLogout\nSleep'

# lowercasing and trimming selected option
eval \$"$(echo -e "$options" | $rofi_command | tr [:upper:] [:lower:] | tr -d " ")_command"
