#!/usr/bin/env bash

# Globals
DOTFILES_DIR="$HOME/i3wm"
PROFILES=("all" "desktop" "terminal")
PROFILE_SELECT="terminal"
GT_USR=""
GT_EML=""
VERINST=false
DESKTOP_LIST=(
  "$DOTFILES_DIR/i3/config:$HOME/.config/i3/config"         \
  "$DOTFILES_DIR/dunst/dunstrc:$HOME/.config/dunst/dunstrc" \
  "$DOTFILES_DIR/X/xresources:$HOME/.Xresources"            \
  "$DOTFILES_DIR/X/xinitrc:$HOME/.xinitrc"                  \
  "$DOTFILES_DIR/X/xbindkeysrc:$HOME/.xbindkeysrc"          \
  "$DOTFILES_DIR/X/xmodmap:$HOME/.Xmodmap"                  \
)
TERMINAL_LIST=(
  "$DOTFILES_DIR/zsh/zshrc:$HOME/.zshrc"                \
  "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf"       \
  "$DOTFILES_DIR/git/gitconfig:$HOME/.gitconfig"        \
  "$DOTFILES_DIR/git/gitignore:$HOME/.gitignore_global" \
  "$DOTFILES_DIR/vim/vimrc:$HOME/.vimrc"                \
  "$DOTFILES_DIR/vim/plugin/*:$HOME/.vim/plugin"        \
  "$DOTFILES_DIR/vim/spell/*:$HOME/.vim/spell"          \
)

# ANSI Escape Codes
BOLD="\033[1m"
UNDR="\033[4m"
ENDL="\033[0m"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -p|--profile)
      PROFILE_SELECT=$2; shift ;;
    -v|--verify-install)
      VERINST=true; shift ;;
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

function link-file-list() {
  local file_list=$1[@]
  local file_list=("${!file_list}")

  for file in "${file_list[@]}"; do
    local source="${file%%:*}"
    local destination="${file##*:}"

    link-file "$source" "$destination"
  done
}

function verify-install() {
  echo "Verifying Install"
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

[[ $VERINST = true ]] && verify-install

function desktop() {
  mkdir -p ~/.config/i3
  mkdir -p ~/.config/dunst

  link-file-list 'DESKTOP_LIST'
}

function terminal() {

  link-file-list 'TERMINAL_LIST'

  # Install fzf
  source $DOTFILES_DIR/zsh/plugins/fzf/install

  # Make vim directories
  mkdir -p ~/.vim/plugin
  mkdir -p ~/.vim/spell

  # Override gitconfig
  [ ! -z $GT_USR ] && git config --global user.name  "$GT_USR"
  [ ! -z $GT_EML ] && git config --global user.email "$GT_EML"
}

function all() {
  desktop
  terminal
}

echo -e "${UNDR}Please Install:${ENDL} zsh, vim, tmux; optionally i3wm, jq, lemonbar, the-silver-searcher"
echo -e "\nCloning i3wm Repository"
if [ -d $HOME/i3wm ]; then
  echo "-> Found $HOME/i3wm"
else
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $HOME/i3wm &>/dev/null
fi

echo -e "\nInstalling config version ${BOLD}$(git rev-parse HEAD)${ENDL}"
echo -e "\nSymlinking files"
# Symlink Files
for i in ${PROFILES[@]}; do
  if [ $i = $PROFILE_SELECT ]; then
    $PROFILE_SELECT; echo -e "\nInstall Complete! Restart your terminal."; exit 0
  fi
done
echo -e "\"$PROFILE_SELECT\" is not a valid profile: ["${PROFILES[@]}"]"; exit 1
