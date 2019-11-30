#!/bin/bash


res=$(echo "" | rofi -sep "|" -dmenu -i -p 'Power Menu: ' "") 
if [ $res = $res ]; then
  firefox $res
fi

