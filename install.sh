#!/usr/bin/env bash

DOTFILES_DIR="$HOME/i3wm"
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

function link-file() {
  ln -sfv $1 $2 | sed "s/'//g"
}

function verify-install() {
  echo "Verifying Install"
  file=(
  $DOTFILES_DIR/vim/vimrc \
  $DOTFILES_DIR/zsh/zshrc \
  $DOTFILES_DIR/X/xbindkeysrc \
  $DOTFILES_DIR/X/xmodmap \
  $DOTFILES_DIR/X/xinitrc \
  $DOTFILES_DIR/tmux/tmux.conf \
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

echo -e "Please Install: zsh, vim, tmux; optionally i3wm, jq, lemonbar"
echo -e "\nCloning i3wm Repository"
if [ -d $HOME/i3wm ]; then
  echo "-> Found $HOME/i3wm"
else
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $HOME/i3wm &>/dev/null
fi

if [[ $STINST = true ]]; then install-st; fi

echo -e "\nSymlinking files"
# Symlink Files
link-file $DOTFILES_DIR/vim/vimrc ~/.vimrc
link-file $DOTFILES_DIR/zsh/zshrc ~/.zshrc
link-file $DOTFILES_DIR/X/xbindkeysrc ~/.xbindkeysrc
link-file $DOTFILES_DIR/X/xmodmap ~/.Xmodmap
link-file $DOTFILES_DIR/X/xinitrc ~/.xinitrc
link-file $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
link-file $DOTFILES_DIR/git/gitconfig ~/.gitconfig
link-file $DOTFILES_DIR/ssh/config ~/.ssh/config
link-file $DOTFILES_DIR/git/gitignore ~/.gitignore_global

# Symlink Directories
mkdir -p ~/.vim/plugin
ln -sfv $DOTFILES_DIR/vim/plugin/* ~/.vim/plugin/ | sed "s/'//g"

echo -e "\nInstall Complete! Restart your terminal."
