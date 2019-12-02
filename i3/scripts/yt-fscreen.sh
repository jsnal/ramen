#!/bin/bash

killall mpv

linkg=$(xclip -selection c -o)
linkyou=$(echo $linkg | grep youtube.com/watch?)
linkpdf=$(echo $linkg | grep pdf)

if [ $linkyou = $linkg ]; then
    mpv $linkg &
    xdotool key super+9
    echo "echo '[NOTIFY:LOADING YOUTUBE VIDEO]'" > ~/i3wm/polybar/error.sh
    sleep 3 
    echo "echo ''" > ~/i3wm/polybar/error.sh
else
    echo "echo '[ERROR:NOT A VALID LINK]'" > ~/i3wm/polybar/error.sh
    sleep 3 
    echo "echo ''" > ~/i3wm/polybar/error.sh
fi
