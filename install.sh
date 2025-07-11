#!/usr/bin/env bash
#
# Install script for ramen
# File:    install.sh
# Author:  Jason Long <jsnal>

# Set the default path to the current path
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# List of files to install
INSTALL_MANIFEST=(
    "$DOTFILES_DIR/zsh/zshenv:$HOME/.zshenv"                           \
    "$DOTFILES_DIR/zsh/zshrc:$HOME/.zshrc"                             \
    "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf"                    \
    "$DOTFILES_DIR/vim/vimrc:$HOME/.vim/vimrc"                         \
    "$DOTFILES_DIR/vim/colors/defaultpp.vim:$HOME/.vim/colors/defaultpp.vim" \
)

# ANSI Escape Codes
BOLD="\033[1m"
UNDR="\033[4m"
ENDL="\033[0m"

# Conduct the install process in the following order:
#
#   1. Check if the repository exists locally; If it doesn't clone it.
#   2. Notify the user of the current git commit hash they are about to install.
#   3. Verify all the project files are present before starting.
#   4. Perform the install.
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

echo -e "\nInstalling ramen version ${BOLD}$(git --git-dir="$DOTFILES_DIR/.git" rev-parse HEAD)${ENDL}\n"

echo -e "${UNDR}Verifying install${ENDL}"

# Check if the files in the install manifest actually exist
for i in ${INSTALL_MANIFEST[@]}; do
    source="${i%%:*}"
    if [ -f "$source" ]; then
        echo -e "(File)    $source"
    elif [ -d "$source" ]; then
        echo -e "(Dir)     $source"
    else
        echo -e "(Missing) $source\nInstall not verified"
        exit 1
    fi
done

echo -e "\n${UNDR}Symlinking files${ENDL}"

# Create needed directories
mkdir -p $HOME/.vim/colors

# Symlink all files in install manifest
for file in "${INSTALL_MANIFEST[@]}"; do
    source="${file%%:*}"
    destination="${file##*:}"
    ln -sfv "$source" "$destination" | sed "s/'//g"
done

echo -e "\n${BOLD}Install Complete!${ENDL}"
