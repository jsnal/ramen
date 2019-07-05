#!/usr/bin/env bash

DOTFILES_DIR="$HOME/i3wm"
PROFILES=("all" "desktop" "terminal" "minimal")
PROFILE_SELECT="terminal"
VERINST=false
STINST=false

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -p|--profile)
      PROFILE_SELECT=$2; shift ;;
    -v|--verify-install)
      VERINST=true; shift ;;
    -st|--simple-terminal)
      STINST=true; shift ;;
    --git-user)
      GT_USR=$2; shift ;;
    --git-email)
      GT_EML=$2; shift ;;
    *)
      POSITIONAL+=("$1"); shift ;;
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
  $DOTFILES_DIR/git/gitconfig \
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
  echo -e 'Please Install: libx11-dev libxft-dev libxext-dev fontconfig'
  cd $HOME/i3wm/st && sudo make install
  exit 0
}

if [[ $STINST = true ]]; then install-st; fi
if [[ $VERINST = true ]]; then verify-install; fi

function desktop() {
  link-file $DOTFILES_DIR/i3/config ~/.config/i3/config
  link-file $DOTFILES_DIR/X/xinitrc ~/.xinitrc
  link-file $DOTFILES_DIR/X/xbindkeysrc ~/.xbindkeysrc
  link-file $DOTFILES_DIR/X/xmodmap ~/.Xmodmap
}

function terminal() {
  link-file $DOTFILES_DIR/zsh/zshrc ~/.zshrc
  source $DOTFILES_DIR/zsh/plugins/fzf/install
  link-file $DOTFILES_DIR/tmux/tmux.conf ~/.tmux.conf
  link-file $DOTFILES_DIR/git/gitconfig ~/.gitconfig
  link-file $DOTFILES_DIR/git/gitignore ~/.gitignore_global

  mkdir -p ~/.vim/plugin
  link-file $DOTFILES_DIR/vim/vimrc ~/.vimrc
  ln -sfv $DOTFILES_DIR/vim/plugin/* ~/.vim/plugin/ | sed "s/'//g"

  [ ! -z $GT_USR ] && git config --global user.name  "$GT_USR"
  [ ! -z $GT_EML ] && git config --global user.email "$GT_EML"
}

function all() {
  desktop
  terminal
  link-file $DOTFILES_DIR/ssh/config ~/.ssh/config
}

function minimal() {
  wget -O ~/.zshrc http://jasonlong24.crabdance.com/min/zshrc.min
  wget -O ~/.tmux.conf http://jasonlong24.crabdance.com/min/tmux.min
  wget -O ~/.vimrc http://jasonlong24.crabdance.com/min/vimrc.min
}

echo -e "Please Install: zsh, vim, tmux; optionally i3wm, jq, lemonbar, the-silver-searcher"
echo -e "\nCloning i3wm Repository"
if [ -d $HOME/i3wm ]; then
  echo "-> Found $HOME/i3wm"
else
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $HOME/i3wm &>/dev/null
fi

echo -e "\nSymlinking files"
# Symlink Files
for i in ${PROFILES[@]}; do
  if [ $i = $PROFILE_SELECT ]; then
    $PROFILE_SELECT; echo -e "\nInstall Complete! Restart your terminal."; exit 0
  fi
done
echo -e "\"$PROFILE_SELECT\" is not a valid profile: ["${PROFILES[@]}"]"; exit 1
