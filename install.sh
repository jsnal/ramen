#!/bin/bash
# Install Script
# ./install.sh [function]

afterinstallline=$(wc -l .afterinst.sh | awk '{print $1}')

function deps() {
  git pull --recurse-submodules origin master
  os=$(cat /etc/issue | head -n +1 | awk '{print $1}')

  if [ $os = "Ubuntu" ] 
  then
    echo "$(tput setaf 1)Operating System... Ubuntu$(tput sgr0)"
    sudo apt-get install zsh vim curl i3
  elif [ $os = "Arch" ]
  then
    echo "$(tput setaf 1)Operating System... Arch$(tput sgr0)"
    #sudo pacman -S zsh vim curl i3-gaps
  else
    echo "Please install (zsh, vim, curl, i3), before resuming"
    exit
  fi
}

function install() {
  read -p "$(tput setaf 1)This may overwrite existing files in your home directory. Are you sure? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
  deps 
  chsh -s $(which zsh)
  mkdir $HOME/.config
  zsh/plugins/fzf/install

  echo "Installing Configs... \n"
  ln zsh/zshrc $HOME/.zshrc
  ln i3/config $HOME/.config/i3/config
  ln vimrc $HOME/.vimrc
  ln X/xresources $HOME/.Xresources
  ln X/xmodmap $HOME/.Xmodmap
  ln X/xbindkeysrc $HOME/.xbindkeysrc
  ln tmux.conf $HOME/.tmux.conf
  ln polybar/config $HOME/.config/polybar/config

  echo "Installing Vim.. \n"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +":PlugInstall" +qa
  afterInstall
  else
    echo "Install Stopped"
  fi	
}

function shell() {
  read -p "$(tput setaf 1)This may overwrite existing files in your home directory. Are you sure? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    deps
    chsh -s $(which zsh)
    zsh/plugins/fzf/install

    echo "Installing Shell... \n"
    ln zsh/zshrc $HOME/.zshrc
    ln X/xresources $HOME/.Xresources
    ln X/xmodmap $HOME/.Xmodmap
    ln X/xbindkeysrc $HOME/.xbindkeysrc
    ln tmux.conf $HOME/.tmux.conf
    ln .gitignore $HOME/.gitignore
    ln .gitconfig $HOME/.gitconfig
    afterInstall
  fi
}

function vi() {
  read -p "$(tput setaf 1)This may overwrite existing files in your home directory. Are you sure? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    deps
    echo "Installing Vim... \n"
    ln vimrc $HOME/.vimrc
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +":PlugInstall" +qa
    afterInstall
    exit
  fi
}

function clean() {
   read -p "$(tput setaf 1)This may overwrite existing files in your home directory. Are you sure? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleaning Config Files... \n"
    rm $HOME/.zshrc
    rm $HOME/.config/i3/config
    rm $HOME/.vimrc
    rm $HOME/.Xresources
    rm $HOME/.tmux.conf
    rm $HOME/.config/polybar/config
    rm $HOME/.gitignore
    rm $HOME/.gitconfig
    echo "Repository Cleaned..."
    afterInstall
  fi
}

function afterInstall() {
  echo "Running After Installation Config... "
  if [ $afterinstallline -gt 1 ]; then
    ./.afterinst.sh
  else
    echo ">Nothing to run in .afterinst... "
  fi
  echo "Install Finished! Logout for changes to take affect."
}
"$@"
