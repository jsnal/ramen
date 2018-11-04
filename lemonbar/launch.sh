#!/usr/bin/env bash

killall -q lemonbar

while pgrep -u $UID -x lemonbar >/dev/null; do sleep 1; done

~/i3wm/lemonbar/lemon.sh | lemonbar -pb | sh
echo "lemon launch"
