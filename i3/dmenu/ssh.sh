#!/bin/bash

res=$(echo "sony|nextcloud|zelon|rig" | rofi -sep "|" -dmenu -i -p 'Window Options: ' "")

if [ $res = "sony" ]; then
	exec urxvt -e ssh ip4gjb@10.52.2.28
fi
if [ $res = "nextcloud" ]; then
  exec urxvt -e ssh jason@10.52.2.2
fi
if [ $res = "zelon" ]; then
  exec urxvt -e ssh int0x191f2@matrix.zelon.net
fi
if [ $res = "rig" ]; then
  exec urxvt -e ssh ip4gjb@matrix.zelon.net -p 6666  
fi
exit 0
