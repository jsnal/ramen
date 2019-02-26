#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES=("zsh" "curl" "vim" "jq" "git")
WEBINST=false
VERINST=false
CIINST=false

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -w|--web)
      WEBINST=true
      shift
      ;;
    -v|--verify-install)
      VERINST=true
      shift
      ;;
    -ci|--count-integration)
      CIINST=true
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

echo "Checking Installed Packages"
for i in "${PACKAGES[@]}"; do
  if echo $ignore_list | grep -q $i; then
    echo '' &>/dev/null
  else
    dpkg -s $i &> /dev/null
  fi
  if [ $? -eq 0 ]; then
    if echo $ignore_list | grep -q $i; then
      echo "-> $i Ignored"
    else
      echo "-> $i Installed"
    fi
  else
    echo -e "Install Failed\nPlease Install ${PACKAGES[@]}"
    read -p "Do you wish to install this program? " response
    case $response in
      [Yy]* ) sudo apt-get install ${PACKAGES[@]}; echo -e "\nPackages installed."; break;;
      [Nn]* ) exit 1;;
      * ) echo "Please answer yes or no.";;
    esac
  fi
done

function web-install() {
  echo "Cloning the Dotfiles"
  DOTFILES_DIR="/home/$(whoami)/i3wm"
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $DOTFILES_DIR &>/dev/null
}

function verify-install() {
  echo "Verifying Install"
  file=(
  $DOTFILES_DIR/vim/vimrc \
  $DOTFILES_DIR/zsh/zshrc \
  $DOTFILES_DIR/X/xbindkeysrc \
  $DOTFILES_DIR/X/xmodmap \
  $DOTFILES_DIR/X/xinitrc \
  $DOTFILES_DIR/tmux.conf \
  $DOTFILES_DIR/.gitconfig \
  $DOTFILES_DIR/i3/config \
  )
  for i in ${file[@]}; do
    if [ -f "$i" ]; then
      echo "-> $i Found"
    else
      echo "$i not found."
      echo "Install not verified"
      exit 1
    fi
  done
  exit 0
}

if [[ $WEBINST = true ]]; then web-install; fi
if [[ $VERINST = true ]]; then verify-install; fi


echo "Installing dotfiles"
ln -sfv $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sfv $DOTFILES_DIR/zsh/zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/X/xbindkeysrc ~/.xbindkeysrc
ln -sfv $DOTFILES_DIR/X/xmodmap ~/.Xmodmap
ln -sfv $DOTFILES_DIR/X/xinitrc ~/.xinitrc
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

echo "Installing zsh"
$DOTFILES_DIR/zsh/plugins/fzf/install

if [[ $CIINST = false ]]; then
  echo "Installing vim"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +":PlugInstall" +qa

  read -p "Install YCM? " response
  case $response in
    [Yy]* )
      if [[ $(vim --version | grep -c -w '+python') = 1 || $(vim --version | grep -c -w '+python3') = 1 ]]; then
        python3 $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer
      fi
      ;;
    [Nn]* ) echo "No YCM";;
    * ) echo "Please answer yes or no.";;
  esac

  chsh -s $(which zsh)
fi

echo "Install Complete! Restart your terminal."
