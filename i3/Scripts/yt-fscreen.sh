#!/bin/bash

killall mpv

linkg=$(xclip -selection c -o)
linkgrep=$(echo $linkg | grep youtube.com/watch?)

if [ $linkgrep = $linkg ]; then
    mpv $linkg &
    xdotool key super+9
    echo "echo '[NOTIFY:LOADING YOUTUBE VIDEO]'" > ~/i3wm/polybar/error.sh
    sleep 3 
    echo "echo ''" > ~/i3wm/polybar/error.sh
else
    echo "echo '[ERROR:NOT A VALID YOUTUBE LINK]'" > ~/i3wm/polybar/error.sh
    sleep 3 
    echo "echo ''" > ~/i3wm/polybar/error.sh
fi
