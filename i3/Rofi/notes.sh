#!/bin/bash

res=$(echo "view|edit" | rofi -sep "|" -dmenu -i -p 'Notes Menu: ' "") 
real=$(echo $res | awk '{print $1}')
doc=$(echo $res | awk '{print $2}')

if [ $real = "view" ]; then

  if [ $doc = "gov" ]; then
    evince ~/Notes/2017-2018/Gov/Gov.pdf
  elif [ $doc = "bio" ]; then
    evince ~/Notes/2017-2018/Biology/Biology.pdf
  fi
fi

if [ $real = "edit" ]; then

  if [ $doc = "gov" ]; then
    exec gnome-terminal -- vim +NERDTree ~/Notes/2017-2018/Gov/md +q
  elif [ $doc = "bio" ]; then
    exec gnome-terminal -- vim +NERDTree ~/Notes/2017-2018/Biology/md +q
  fi
fi
