#!/bin/bash

res=$(echo "add-on|vim|vimrc|polybar|zshrc|Xresources|i3config|theme|rofi" | rofi -sep "|" -dmenu -i -p 'Window Options: ' "")

if [ $res = "vimrc" ]; then
	exec urxvt -e vim ~/.vimrc

elif [ $res = "polybar" ]; then
	exec urxvt -e vim ~/i3wm/polybar/config

elif [ $res = "zshrc" ]; then
	exec urxvt -e vim ~/i3wm/zsh/zshrc

elif [ $res = ".Xresources" ]; then
	exec urxvt -e vim ~/.Xresources

elif [ $res = "i3config" ]; then
	exec urxvt -e vim ~/i3wm/i3/config

elif [ $res = "theme" ]; then
	exec urxvt -e vim /home/jason/.oh-my-zsh/themes/jasonzsh.zsh-theme

elif [ $res = "vim" ]; then
	exec urxvt -e vim  
elif [ $res = "rofi" ]; then
	exec urxvt -e vim +NERDTree ~/i3wm/i3/Rofi +q

elif [ $res = "add-on" ]; then
  exec urxvt -e vim +NERDTree ~/Github/vim-nav-firefox +q

fi
