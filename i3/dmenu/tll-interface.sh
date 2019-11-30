#!/usr/bin/env bash

xterm -c tll -hold -e ~/i3wm/i3/Scripts/tll.sh l &
input=$(echo -e "add\nremove" | dmenu -i -l 20 -p Todolist: )

todo=$(echo $input | awk '{ $1=""; print $0  }')

if [[ $(echo $input | awk '{print $1}') = "add" ]]; then
  ~/i3wm/i3/Scripts/tll.sh a "$todo" &
elif [[ $(echo $input | awk '{print $1}') = "remove" ]]; then
  echo "TEST"
  ~/i3wm/i3/Scripts/tll.sh c "$todo" &
fi
xdotool key super+Shift+q 
