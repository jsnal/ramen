#!/bin/bash
 
res=$(echo "logout|reboot|shutdown|lock" | rofi -sep "|" -dmenu -i -p 'Power Menu: ' "") 
if [ $res = "lock" ]; then
    i3lock
fi
if [ $res = "logout" ]; then
    i3-msg exit
fi
if [ $res = "reboot" ]; then
    systemctl reboot
fi
if [ $res = "shutdown" ]; then
    systemctl poweroff
fi
exit 0
