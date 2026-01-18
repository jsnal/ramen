#!/bin/bash

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)
GIT_REV=$(git --git-dir="$ROOT_DIR/.git" rev-parse --short HEAD)

echo -e "Installing from '$ROOT_DIR' ($GIT_REV)\n"

link() {
    echo "LINK    $2"
    [ ! -e "$2" ] && ln -s $1 $2
}

unlink() {
    echo "UNLINK  $2"
    rm $2 2> /dev/null
}

create_dir() {
    echo "MKDIR   $1"
    mkdir -p $1
}

remove_dir() {
    echo "RMDIR   $1"
    rm -rf $1 2> /dev/null
}

install() {
    link $ROOT_DIR/bash/bashrc $HOME/.bashrc
    link $ROOT_DIR/tmux/tmux.conf $HOME/.tmux.conf
    create_dir $HOME/.vim
    link $ROOT_DIR/vim/vimrc $HOME/.vim/vimrc
    link $ROOT_DIR/vim/colors $HOME/.vim/colors
    create_dir $HOME/.config/nvim
    link $ROOT_DIR/nvim/init.lua $HOME/.config/nvim/init.lua
    link $ROOT_DIR/nvim/lsp $HOME/.config/nvim/lsp
    link $ROOT_DIR/nvim/lua $HOME/.config/nvim/lua
    echo -e '\nInstall complete'
}

uninstall() {
    unlink $ROOT_DIR/bash/bashrc $HOME/.bashrc
    unlink $ROOT_DIR/tmux/tmux.conf $HOME/.tmux.conf
    remove_dir $HOME/.vim
    remove_dir $HOME/.config/nvim
    echo -e '\nUninstall complete'
}

[[ $1 = "uninstall" ]] && uninstall || install
