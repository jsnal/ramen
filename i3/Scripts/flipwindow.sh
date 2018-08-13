#!/usr/bin/env bash
# Flip Vertical windows in i3.

state=$(xwininfo -id $(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}') | grep geometry | awk '{print $2}')

if [[ $(echo $state | grep -) == $state ]]; then
  xdotool key super+H && sleep .1 && xdotool key super+H
else
  xdotool key super+L && sleep .1 && xdotool key super+L
fi
