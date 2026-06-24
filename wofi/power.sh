#!/bin/bash
choice=$(echo -e "  Shutdown\n  Reboot\n  Suspend\n  Lock\n  Logout" | wofi --dmenu --prompt "Power:" --width 400 --height 230)
case $choice in
*Shutdown) systemctl poweroff ;;
*Reboot) systemctl reboot ;;
*Suspend) systemctl suspend ;;
*Lock) hyprlock ;;
*Logout) hyprctl dispatch exit ;;
esac
