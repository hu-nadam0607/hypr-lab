#!/usr/bin/env bash

# Opciók definiálása ikonokkal
shutdown="⏻ Shutdown"
reboot="⟳ Reboot"
suspend="󰤄 Suspend"
hibernate="❄ Hibernate"

# Opciók átadása a Rofi-nak
options="$suspend\n$hibernate\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Rendszer" -theme ~/.config/rofi/powermenu.rasi)"

case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
        systemctl suspend
        ;;
    $hibernate)
        systemctl hibernate
        ;;
esac
