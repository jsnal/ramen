#!/usr/bin/env bash
#
# Install script for ramen
# File:    install.sh
# Author:  Jason Long <jsnal>

# Set the default path to the current path
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# ANSI Escape Codes
BOLD="\033[1m"
UNDR="\033[4m"
YELLOW="\033[33m"
GREEN="\033[32m"
RED="\033[31m"
ENDL="\033[0m"

# Conduct the install process in the following order:
#
#   1. Check if the repository exists locally; If it doesn't clone it.
#   2. Notify the user of the current git commit hash they are about to install.
#   3. Verify all the project files are present before starting.
#   4. Finally get the selected profile and install the files accordingly.
#
echo -e "${UNDR}Cloning ramen${ENDL}"

# Check if we're in a the correct git repository
if git --git-dir=$DOTFILES_DIR/.git config -l | grep -q "jsnal/ramen"; then
  echo "-> Found $DOTFILES_DIR"
else
  # If this script is run without being in the repo itself, put the dotfiles in
  # the home directory. This could be changed after they're installed if need be.
  DOTFILES_DIR="$HOME/ramen"
  echo "-> Unable to find $DOTFILES_DIR Cloning..."
  git clone --recursive --quiet https://github.com/jsnal/ramen $DOTFILES_DIR &>/dev/null
fi

# Globals
PROFILES=("all" "desktop" "terminal")
PROFILE_SELECT="terminal"
DESKTOP_LIST=(
  "$DOTFILES_DIR/dunst/dunstrc:$HOME/.config/dunst/dunstrc" \
  "$DOTFILES_DIR/X/xresources:$HOME/.Xresources"            \
  "$DOTFILES_DIR/X/xbindkeysrc:$HOME/.xbindkeysrc"          \
  "$DOTFILES_DIR/X/xmodmap:$HOME/.Xmodmap"                  \
)
TERMINAL_LIST=(
  "$DOTFILES_DIR/zsh/utils:$HOME/.zsh/utils"               \
  "$DOTFILES_DIR/zsh/zshenv:$HOME/.zshenv"                 \
  "$DOTFILES_DIR/zsh/zshrc:$HOME/.zshrc"                   \
  "$DOTFILES_DIR/X/xresources:$HOME/.Xresources"           \
  "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf"          \
  "$DOTFILES_DIR/nvim:$HOME/.config/nvim"                  \
)

# Usage information
function usage() {
  echo './install.sh [OPTIONS]'
  echo -e '\nOptions:'
  echo -e '  -p, --profile [PROFILE] \tChange the install profile. Default terminal'
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

# Verify all of the submodules have been updated
function verify-submodules() {
  local IFS=$'\n'
  local failed=false
  local submodules=($(sed -n -e 's/^.*path = //p' $DOTFILES_DIR/.gitmodules))

  for i in ${submodules[@]}; do
    if [ ! -n "$(find "$DOTFILES_DIR/$i" -maxdepth 0 -type d -empty )" ]; then
      echo -e "(${GREEN}Dir${ENDL})     $DOTFILES_DIR/${i}"
    else
      echo -e "(${RED}Missing${ENDL}) $DOTFILES_DIR/${i}"
      local failed=true
    fi
  done

  if [ "$failed" = true ]; then
    echo -e "(${YELLOW}WARNING${ENDL}) One or more submodule could not be found"
  fi
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

  verify-submodules
}

# Install all the files for the desktop environment
function desktop() {
  mkdir -p $HOME/.config/dunst

  link-file-list 'DESKTOP_LIST'
}

# Install all the files for the terminal environment.
function terminal() {
  mkdir -p $HOME/.config/nvim

  link-file-list 'TERMINAL_LIST'

  # Set the the ramen home
  echo "export _ramen[HOME]=$DOTFILES_DIR" > $HOME/.zsh/.zshrc.local

  # Create tmp vim directories
  # mkdir -p $HOME/.config/tmp/{backup,swap,undo,view}
}

# Install all the files for the both the terminal and desktop environment.
function all() {
  desktop
  terminal
}

echo -e "\nInstalling config version ${BOLD}$(git --git-dir="$DOTFILES_DIR/.git" rev-parse HEAD)${ENDL}\n"

# Verify all of the files are cloned properly
verify-install

# Find the profile selection and run the corrosponding function
echo -e "\n${UNDR}Symlinking files${ENDL}"
for i in ${PROFILES[@]}; do
  if [ $i = $PROFILE_SELECT ]; then
    $PROFILE_SELECT
    echo -e "\n${BOLD}Install Complete! Restart your terminal.${ENDL}"
    exit 0
  fi
done
echo -e "\"$PROFILE_SELECT\" is not a valid profile: ["${PROFILES[@]}"]"; exit 1
