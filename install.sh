#!/bin/bash

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	
git pull --recurse-submodules origin master
sudo apt-get install zsh vim curl i3
chsh -s $(which zsh)
mkdir -p $HOME/.zsh/plugins
mkdir $HOME/.config
zsh/plugins/fzf/install

echo "Installing Configs... \n"
ln zsh/zshrc $HOME/.zshrc
ln i3/config $HOME/.config/i3/config
ln vimrc $HOME/.vimrc
ln xresources $HOME/.Xresources
ln tmux.conf $HOME/.tmux.conf
ln polybar/config $HOME/.config/polybar/config

echo "Installing Vim.. \n"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
urxvt -e vim -c ":PlugInstall"

else
	echo "Install Stopped"
fi	
