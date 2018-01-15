#!/bin/bash

res=$(echo "sony|nextcloud|zelon" | rofi -sep "|" -dmenu -i -p 'Window Options: ' "")

if [ $res = "sony" ]; then
	exec gnome-terminal -- ssh ip4gjb@10.52.2.28
fi
if [ $res = "nextcloud" ]; then
  exec gnome-terminal -- ssh jason@10.52.2.2
fi
if [ $res = "zelon" ]; then
  exec gnome-terminal -- ssh int0x19152@matrix.zelon.net

fi
exit 0
