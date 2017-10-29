#!/bin/bash

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	
git pull origin master
echo ""

#Dependencies

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
yaourt -S zsh i3-gaps i3blocks rofi scrot gyazo polybar siji-git nerd-fonts-complete gnome-terminal

#Check if Directory exists
	
	echo "Copying and syncing your files"
	
	#i3
	if [ -d "$HOME/.config/i3" ];then
		echo "i3 Directory found"
		#rm -r $HOME/.config/i3
		cp -r ~/i3wm/i3 $HOME/.config/
		echo "$HOME/i3wm/i3 $HOME/.config"
	else
		echo "i3 Directory not found... Please install i3"
	fi
	
	#polybar
	if [ -d "$HOME/.config/polybar" ];then
		echo "Polybar Directory found"
		#rm -r $HOME/.config/polybar
		cp -r ~/i3wm/polybar $HOME/.config/
		echo "$HOME/i3wm/polybar --> $HOME/.config"
	else
		echo "Polybar Directory not found... Making directory... Please run this script again"
		mkdir $HOME/.config/polybar
	fi	

	#zsh
	if [ -f "$HOME/.zshrc" ];then
		echo ".zshrc found"
		#rm -r $HOME/.zshrc
		cp -r $HOME/i3wm/zsh/zshrc $HOME/.zshrc
		echo "$HOME/i3wm/zsh/zshrc --> $HOME/.zshrc"
	else
		cp -r $HOME/i3wm/zsh/zshrc $HOME/.zshrc
                echo "$HOME/i3wm/zsh/zshrc --> $HOME/.zshrc"

	fi

	#zsh theme
	if [ -d "$HOME/.oh-my-zsh/themes" ];then
		echo ".oh-my-zsh found"
		rm -r $HOME/.oh-my-zsh/themes/jasonzsh.zsh-theme
		cp -r $HOME/i3wm/zsh/jasonzsh.zsh-theme $HOME/.oh-my-zsh/themes
		echo "$HOME/i3wm/zsh/jasonzsh.zsh-theme --> $HOME/.oh-my-zsh/themes"
	fi
else
	echo "Install Stopped"
fi	
