#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES=("python-pip" "zsh" "curl" "vim" "jq" "git")
PROFILEINST=false
VERINST=false
CIINST=false
STINST=false

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -pfl|--profile)
      PROFILEINST=true
      PROFILE_SELECT=$2
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
    -st|--simple-terminal)
      STINST=true
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

function install-st() {
  git submodule update --init --recursive
  sudo apt-get install libx11-dev libxft-dev libxext-dev fontconfig
  cd $HOME/i3wm/st && sudo make install
  exit 0
}

if [[ $WEBINST = true ]]; then web-install; fi
if [[ $VERINST = true ]]; then verify-install; fi

echo "Checking Installed Packages"
for i in "${PACKAGES[@]}"; do
  if echo $ignore_list | grep -q $i; then
    echo '' &>/dev/null
  else
    pacman -Qi $i &> /dev/null
  fi
  if [ $? -eq 0 ]; then
    if echo $ignore_list | grep -q $i; then
      echo "-> $i Ignored"
    else
      echo "-> $i Installed"
    fi
  else
    echo -e "Install Failed\nPlease Install ${PACKAGES[@]}"
  fi
done

echo "Cloning i3wm Repository"
if [ -d $HOME/i3wm ]; then
  echo "-> Found $HOME/i3wm"
else
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $HOME/i3wm &>/dev/null
fi

if [[ $STINST = true ]]; then install-st; fi

echo "Symlinking files"
# Symlink Files
ln -sfv $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sfv $DOTFILES_DIR/zsh/zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/X/xbindkeysrc ~/.xbindkeysrc
ln -sfv $DOTFILES_DIR/X/xmodmap ~/.Xmodmap
ln -sfv $DOTFILES_DIR/X/xinitrc ~/.xinitrc
ln -sfv $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
ln -sfv $DOTFILES_DIR/.gitconfig ~/.gitconfig

# Symlink Directories
ln -sfv $DOTFILES_DIR/vim/plugin ~/.vim

echo "Install Complete! Restart your terminal."
