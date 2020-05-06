#!/usr/bin/env bash

# Globals
DOTFILES_DIR="$HOME/i3wm"
PROFILES=("all" "desktop" "terminal")
PROFILE_SELECT="terminal"
GT_USR=""
GT_EML=""
DESKTOP_LIST=(
  "$DOTFILES_DIR/i3/config:$HOME/.config/i3/config"         \
  "$DOTFILES_DIR/dunst/dunstrc:$HOME/.config/dunst/dunstrc" \
  "$DOTFILES_DIR/X/xresources:$HOME/.Xresources"            \
  "$DOTFILES_DIR/X/xinitrc:$HOME/.xinitrc"                  \
  "$DOTFILES_DIR/X/xbindkeysrc:$HOME/.xbindkeysrc"          \
  "$DOTFILES_DIR/X/xmodmap:$HOME/.Xmodmap"                  \
)
# TODO: consider moving plugin symlinks to `.zshrc`
TERMINAL_LIST=(
  "$DOTFILES_DIR/zsh/plugins/zsh-autopair/autopair.plugin.zsh:$HOME/.zsh/plugins/autopair.plugin.zsh"                           \
  "$DOTFILES_DIR/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh:$HOME/.zsh/plugins/zsh-syntax-highlighting.zsh" \
  "$DOTFILES_DIR/zsh/zshenv:$HOME/.zshenv"              \
  "$DOTFILES_DIR/zsh/zshrc:$HOME/.zsh/.zshrc"           \
  "$DOTFILES_DIR/zsh/startup:$HOME/.zsh/startup"        \
  "$DOTFILES_DIR/zsh/scripts:$HOME/.zsh/scripts"        \
  "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf"       \
  "$DOTFILES_DIR/git/gitconfig:$HOME/.gitconfig"        \
  "$DOTFILES_DIR/git/gitignore:$HOME/.gitignore_global" \
  "$DOTFILES_DIR/vim/vimrc:$HOME/.vim/vimrc"            \
  "$DOTFILES_DIR/vim/plugin:$HOME/.vim/plugin"          \
  "$DOTFILES_DIR/vim/spell:$HOME/.vim/spell"            \
  "$DOTFILES_DIR/vim/ultisnips:$HOME/.vim/ultisnips"    \
)

# ANSI Escape Codes
BOLD="\033[1m"
UNDR="\033[4m"
GREEN="\033[32m"
RED="\033[31m"
ENDL="\033[0m"

# Usage information
function usage() {
  echo './install.sh [OPTIONS]'
  echo -e '\nOptions:'
  echo -e '  -p, --profile [PROFILE] \tChange the install profile. Default terminal'
  echo -e '  --git-user [USER]       \tSet the git username in ~/.gitconfig'
  echo -e '  --git-email [EMAIL]     \tSet the git email in ~/.gitconfig'
  echo -e '\nProfiles:'
  echo -e '  all      \tInstalls configuration files for desktop and terminal'
  echo -e '  desktop  \tInstalls just configuration files for desktop'
  echo -e '  terminal \tInstalls just configuration files for terminal'
  exit
}

# Parse command line arguments
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -p|--profile)     PROFILE_SELECT=$2; shift ;;
    -gu|--git-user)   GT_USR=$2;         shift ;;
    -ge|--git-email)  GT_EML=$2;         shift ;;
    -h|--help)        usage;             shift ;;
    *)
      POSITIONAL+=("$1"); shift ;;
  esac
done
set -- "${POSITIONAL[@]}"

# Symlink a file to a destination
function link-file() {
  ln -sfv $1 $2 | sed "s/'//g"
}

# Given an array link the file to a destination
function link-file-list() {
  local file_list=$1[@]
  local file_list=("${!file_list}")

  for file in "${file_list[@]}"; do
    local source="${file%%:*}"
    local destination="${file##*:}"

    [ -d $source ] && mkdir -p $destination && local source="$source/*"
    link-file "$source" "$destination"
  done
}

# Verify that all the files in the project actually exist
function verify-install() {
  echo -e "${UNDR}Verifying Install${ENDL}"
  local files=("${TERMINAL_LIST[@]}" "${DESKTOP_LIST[@]}")

  for i in ${files[@]}; do
    local source="${i%%:*}"
    if [ -f "$source" ]; then
      echo -e "(${GREEN}File${ENDL})    $source"
    elif [ -d "$source" ]; then
      echo -e "(${GREEN}Dir${ENDL})     $source"
    else
      echo -e "(${RED}Unknown${ENDL}) $source\nInstall not verified"
      exit 1
    fi
  done
}

# Install all the files for the desktop environment
function desktop() {
  mkdir -p $HOME/.config/i3
  mkdir -p $HOME/.config/dunst

  link-file-list 'DESKTOP_LIST'
}

# Install all the files for the terminal environment.
function terminal() {
  link-file-list 'TERMINAL_LIST'

  # Install fzf
  source $DOTFILES_DIR/zsh/plugins/fzf/install

  # Override gitconfig
  [ ! -z $GT_USR ] && git config --global user.name  "$GT_USR"
  [ ! -z $GT_EML ] && git config --global user.email "$GT_EML"
}

# Install all the files for the both the terminal and desktop environment.
function all() {
  desktop
  terminal
}

# Conduct the install process in the following order:
#
#   1. Check if the repository exists locally; If it doesn't clone it.
#   2. Notify the user of the current git commit hash they are about to install.
#   3. Verify all the project files are present before starting.
#   4. Finally get the selected profile and install the files accordingly.
#
echo -e "${UNDR}Please Install:${ENDL} zsh, vim, tmux; optionally i3wm, jq, lemonbar, the-silver-searcher\n"
echo -e "${UNDR}Cloning${ENDL} i3wm Repository"
if [ -d $HOME/i3wm ]; then
  echo "-> Found $HOME/i3wm"
else
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $HOME/i3wm &>/dev/null
fi

echo -e "\nInstalling config version ${BOLD}$(git rev-parse HEAD)${ENDL}\n"

verify-install

echo -e "\n${UNDR}Symlinking files${ENDL}"
for i in ${PROFILES[@]}; do
  if [ $i = $PROFILE_SELECT ]; then
    $PROFILE_SELECT
    echo -e "\n${BOLD}Install Complete! Restart your terminal.${ENDL}"
    exit 0
  fi
done
echo -e "\"$PROFILE_SELECT\" is not a valid profile: ["${PROFILES[@]}"]"; exit 1
