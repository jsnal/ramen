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
    sudo apt-get install zsh vim curl
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
  clean
  deps 
  chsh -s $(which zsh)
  mkdir $HOME/.config

  echo "Installing Configs... \n"
  ln -s zsh/zshrc $HOME/.zshrc
  zsh/plugins/fzf/install
  ln i3/config $HOME/.config/i3/config
  ln -s vim/vimrc $HOME/.vimrc
  ln -s X/xresources $HOME/.Xresources
  ln -s X/xmodmap $HOME/.Xmodmap
  ln -s X/xbindkeysrc $HOME/.xbindkeysrc
  ln -s tmux.conf $HOME/.tmux.conf
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

    echo "Installing Shell... \n"
    ln -s zsh/zshrc $HOME/.zshrc
    zsh/plugins/fzf/install
    ln -s X/xresources $HOME/.Xresources
    ln -s X/xmodmap $HOME/.Xmodmap
    ln -s X/xbindkeysrc $HOME/.xbindkeysrc
    ln -s tmux.conf $HOME/.tmux.conf
    ln -s .gitignore $HOME/.gitignore
    ln -s .gitconfig $HOME/.gitconfig
    afterInstall
  fi
}

function vi() {
  read -p "$(tput setaf 1)This may overwrite existing files in your home directory. Are you sure? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    deps
    echo "Installing Vim... \n"
    ln -s vim/vimrc $HOME/.vimrc
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

function pull() {
  read -p "$(tput setaf 1)This may overwrite existing files in your home directory. Are you sure? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd ~/i3wm && git pull origin master
    clean
    install
  else
    echo "Pull Stopped."
  fi
}

function github() {
  rm ~/.gitconfig
  cp ~/i3wm/.gitconfig ~/.gitconfig

  echo Enter github name: && read gitName
  echo Enter github email: && read gitEmail

  read -p "$(tput sgr0)Username: $(tput setaf 2)$gitName $(tput sgr0)Email: $(tput setaf 2)$gitEmail $(tput setaf 1)Is this right? (y/n) $(tput sgr0)" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sed -i "1 i\[user]\nname = $gitName\nemail = $gitEmail\n" ~/.gitconfig 
    echo "Username and Email pushed"
  else
    echo "Stopped Github Setup."
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

function help() {
  printf "./install.sh [function]
    deps            Installs dependencies
    install         Installs entire config including i3 and polybar
    shell           Installs just zsh(plugins) and tmux
    vi              Installs just vim config
    afterInstall    Runs the .afterinst config
    clean           Removes all symlinks to configs
    github          Menu for adding git info to gitconfig
    help            Displays this menu"
}
"$@"
