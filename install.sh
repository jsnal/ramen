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

# List of files to install
FILE_LIST=(
    "$DOTFILES_DIR/zsh/zshenv:$HOME/.zshenv"                           \
    "$DOTFILES_DIR/zsh/zshrc:$HOME/.zshrc"                             \
    "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf"                    \
    "$DOTFILES_DIR/vim/vimrc:$HOME/.vim/vimrc"                         \
    "$DOTFILES_DIR/vim/colors/serape.vim:$HOME/.vim/colors/serape.vim" \
)

# Verify all of the submodules have been updated
function verify_submodules() {
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
function verify_install() {
    echo -e "${UNDR}Verifying Install${ENDL}"

    for i in ${FILE_LIST[@]}; do
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

    verify_submodules
}

# Install all the files.
function install() {
    # Make vim directories
    mkdir -p $HOME/.vim/colors

    for file in "${FILE_LIST[@]}"; do
        local source="${file%%:*}"
        local destination="${file##*:}"
        ln -sfv "$source" "$destination" | sed "s/'//g"
    done
}

echo -e "\nInstalling config version ${BOLD}$(git --git-dir="$DOTFILES_DIR/.git" rev-parse HEAD)${ENDL}\n"

# Verify all of the files are cloned properly
verify_install

# Perform the install
echo -e "\n${UNDR}Symlinking files${ENDL}"
install
echo -e "\n${BOLD}Install Complete!${ENDL}"
