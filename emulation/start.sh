#!/usr/bin/env bash
# Script to launch games using fceux.
# ./start.sh file

while pgrep -u $UID -x fceux >/dev/null; do killall -q fceux; done

if [[ ! $1 = '' ]]; then
  fceux $1 &
  notify-send 'Launching' $(basename $(echo $1)) -t 2000
else
  fceux ~/i3wm/emulation/famicom/tetris-das.nes &
  notify-send 'Launching tetris-das.nes' -t 2000
fi
sleep .5 && i3-msg floating enable, resize set 1024 800, move position center
