#!/bin/bash

prompt=$(echo Power:)
back=$(echo \#000000)
fore=$(echo \#cc0000)
selback=$(echo \#333)
selfore=$(echo \#ffb52a)
res=$(echo -e "logout\nreboot\nshutdown\nlock" | dmenu -b -p $prompt -nb $back -nf $fore -sb $selback -sf $selfore)
if [ $res = "lock" ]; then
    bash ~/i3wm/i3/Scripts/lock.sh 
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
