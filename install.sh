#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES=("zsh" "curl" "vim" "jq" "git")


POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -w|--web)
      echo "$(tput setaf 6)Cloning the Dotfiles$(tput sgr0)"
      DOTFILES_DIR="/home/$(whoami)/i3wm"
      git clone --recursive --quiet https://github.com/JasonLong24/i3wm $DOTFILES_DIR &>/dev/null
      shift 
      ;;
    -i|--ignore)
      ignore_list=$(echo $2 | sed 's/,/ /g')
      shift
      shift
      ;;
    *)
      POSITIONAL+=("$1") 
      shift 
      ;;
  esac
done

set -- "${POSITIONAL[@]}"

echo "$(tput setaf 6)Checking Installed Packages$(tput sgr0)"
for i in "${PACKAGES[@]}"; do
  if echo $ignore_list | grep -q $i; then
    echo '' &>/dev/null
  else
    dpkg -s $i &> /dev/null
  fi
  if [ $? -eq 0 ]; then
    if echo $ignore_list | grep -q $i; then
      echo "-> $i $(tput setaf 1)Ignored$(tput sgr0)"
    else
      echo "-> $i $(tput setaf 2)Installed$(tput sgr0)"
    fi
  else
    echo -e "$(tput setaf 1)Install Failed\nPlease Install ${PACKAGES[@]}$(tput setaf 2)"
    read -p "Do you wish to install this program? $(tput sgr0)" response 
    case $response in
      [Yy]* ) sudo apt-get install ${PACKAGES[@]}; echo -e "\n$(tput setaf 2)Packages installed please rerun the script."; break;;
      [Nn]* ) exit 1;;
      * ) echo "Please answer yes or no.";;
    esac
  fi
done

echo "$(tput setaf 6)Installing dotfiles$(tput sgr0)"
ln -sfv $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sfv $DOTFILES_DIR/zsh/zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/X/xbindkeysrc ~/.xbindkeysrc
ln -sfv $DOTFILES_DIR/X/xmodmap ~/.xmodmap
ln -sfv $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -sfv $DOTFILES_DIR/.gitconfig ~/.gitconfig

if [[ -d ~/.config/i3 ]]; then
  ln -sfvv $DOTFILES_DIR/i3/config ~/.config/i3/.config
else
  mkdir -p ~/.config/i3
  ln -sfv $DOTFILES_DIR/i3/config ~/.config/i3/.config
fi

if [[ -d ~/.config/polybar ]]; then
  ln -sfv $DOTFILES_DIR/polybar/config ~/.config/polybar/config
else
  mkdir -p ~/.config/polybar
  ln -sfv $DOTFILES_DIR/polybar/config ~/.config/polybar/config
fi

echo "$(tput setaf 6)Installing zsh$(tput sgr0)"
$DOTFILES_DIR/zsh/plugins/fzf/install

echo "$(tput setaf 6)Installing vim$(tput sgr0)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +":PlugInstall" +qa

chsh -s $(which zsh)
echo "$(tput setaf 2)Install Complete! Restart your terminal."
