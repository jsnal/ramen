#!/bin/bash

prompt=$(echo Power:)
back=$(echo \#000000)
fore=$(echo \#cc0000)
selback=$(echo \#333)
selfore=$(echo \#ffb52a)
res=$(echo -e "logout\nreboot\nshutdown\nlock" | dmenu -b -p $prompt -nb $back -nf $fore -sb $selback -sf $selfore)

case "$res" in
  "lock")   bash ~/i3wm/i3/Scripts/lock.sh ;;
  "logout") i3-msg exit ;;
  "reboot")
    notify-send -u critical "Warning: You're about to reboot"
    if [ $(echo -e "No\nYes" | dmenu -i -b -p "$1" -nb darkred -sb red -sf white -nf gray -fn mono) == "Yes" ]; then
      st -e sudo reboot
    fi
    ;;
  "shutdown")
    notify-send -u critical "Warning: You're about to shutdown"
    if [ $(echo -e "No\nYes" | dmenu -i -b -p "$1" -nb darkred -sb red -sf white -nf gray -fn mono) == "Yes" ]; then
      st -e sudo shutdown
    fi
    ;;
  *)
    notify-send "Nothing selected. Exiting..." ;;
esac
