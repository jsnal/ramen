#!/bin/bash

prompt=$(echo Power:)
back=$(echo \#000000)
fore=$(echo \#cc0000)
selback=$(echo \#333)
selfore=$(echo \#ffb52a)
res=$(echo -e "vimrc\npolybar\nzshrc\nxresources\ni3\nscripts" | dmenu -b -p $prompt -nb $back -nf $fore -sb $selback -sf $selfore)

case $res in
  vimrc) st -e vim ~/.vimrc ;;
  polybar) st -e vim ~/.config/polybar/config ;;
  zshrc) st -e vim ~/.zshrc ;;
  xresources) st -e vim ~/.Xresources ;;
  i3) st -e vim ~/.config/i3/config ;;
  scripts) st -e vim ~/i3wm/i3/Scripts ;;
  *) echo "echo '[NOTIFY:NOT A VALID CONFIG]'" > ~/i3wm/polybar/error.sh; sleep 3; echo "echo ''" > ~/i3wm/polybar/error.sh ;;
esac
