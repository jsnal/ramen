#!/bin/bash
 
res=$(echo "inner|outer|growh|groww|shrinkh|shrinkw|back" | rofi -sep "|" -dmenu -i -p 'Window Options: ' "")

echo "$res"

if [[ "$res" == *"inner"* ]]; then
	num=$(echo "$res" | grep -oP "inner\s+\K\w+")
	echo "$num"
	i3-msg gaps inner all set $num 
fi
if [[ "$res" == *"outer"* ]]; then
	num=$(echo "$res" | grep -oP "outer\s+\K\w+")
	echo "$num"
	i3-msg gaps outer all set $num
fi
if [[ "$res" == *"groww"* ]]; then
	num=$(echo "$res" | grep -oP "groww\s+\K\w+")
	echo "$num"
	i3-msg resize grow width $num px or $num ppt
fi
if [[ "$res" == *"shrinkw"* ]]; then
        num=$(echo "$res" | grep -oP "shrinkw\s+\K\w+")
        echo "$num"
        i3-msg resize shrink width $num px or $num ppt
fi
if [[ "$res" == *"shrinkh"* ]]; then
        num=$(echo "$res" | grep -oP "shrinkh\s+\K\w+")
        echo "$num"
        i3-msg resize shrink height $num px or $num ppt
fi
if [[ "$res" == *"growh"* ]]; then
        num=$(echo "$res" | grep -oP "growh\s+\K\w+")
        echo "$num"
        i3-msg resize shrink width $num px or $num ppt
fi
if [ "$res" = "back" ]; then
	i3-msg gaps outer all set 5
	i3-msg gaps inner all set 0
fi
