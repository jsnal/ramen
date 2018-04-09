#!/bin/bash

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
	
git pull --recurse-submodules origin master
os=$(lsb_release -i | awk '{print $3}')
if [ $os != "Ubuntu" ]; then
  echo "Please install (zsh, vim, curl, i3), before resuming"
  exit
else
  sudo apt-get install zsh vim curl i3
fi
chsh -s $(which zsh)
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
vim +":PlugInstall" +qa

echo "Install Finished! Logout for changes to take affect."
else
	echo "Install Stopped"
fi	
