#!/bin/bash
 
res=$(echo "inner|outer|growh|groww|shrinkh|shrinkw|back" | rofi -sep "|" -dmenu -i -p 'Window Options: ' "")

echo "$res"
num=$(echo "$res" | awk '{print $2}')

if [[ "$res" == *"inner"* ]]; then
	echo "$num"
	i3-msg gaps inner all set $num 
fi
if [[ "$res" == *"outer"* ]]; then
	echo "$num"
	i3-msg gaps outer all set $num
fi
if [[ "$res" == *"groww"* ]]; then
	echo "$num"
	i3-msg resize grow width $num px or $num ppt
fi
if [[ "$res" == *"shrinkw"* ]]; then
        echo "$num"
        i3-msg resize shrink width $num px or $num ppt
fi
if [[ "$res" == *"shrinkh"* ]]; then
        echo "$num"
        i3-msg resize shrink height $num px or $num ppt
fi
if [[ "$res" == *"growh"* ]]; then
        echo "$num"
        i3-msg resize shrink width $num px or $num ppt
fi
if [ "$res" = "back" ]; then
	i3-msg gaps outer all set 3
	i3-msg gaps inner all set 0
fi
