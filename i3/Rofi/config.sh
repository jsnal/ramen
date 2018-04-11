#!/bin/bash

res=$(echo "urls|add-on|vim|vimrc|polybar|zshrc|Xresources|i3config|theme|rofi" | rofi -sep "|" -dmenu -i -p 'Window Options: ' "")

if [ $res = "vimrc" ]; then
	exec xterm -e vim ~/.vimrc

elif [ $res = "polybar" ]; then
	exec xterm -e vim ~/i3wm/polybar/config

elif [ $res = "zshrc" ]; then
	exec xterm -e vim ~/i3wm/zsh/zshrc

elif [ $res = ".Xresources" ]; then
	exec xterm -e vim ~/.xresources

elif [ $res = "i3config" ]; then
	exec xterm -e vim ~/i3wm/i3/config

elif [ $res = "theme" ]; then
	exec xterm -e vim /home/jason/.oh-my-zsh/themes/jasonzsh.zsh-theme

elif [ $res = "vim" ]; then
	exec xterm -e vim  
elif [ $res = "rofi" ]; then
	exec xterm -e vim +NERDTree ~/i3wm/i3/Rofi +q

elif [ $res = "add-on" ]; then
  exec xterm -e vim +NERDTree ~/Github/vim-nav-firefox +q

elif [ $res = "urls" ]; then
  exec xterm -e vim ~/i3wm/newsbeuter/urls
fi
