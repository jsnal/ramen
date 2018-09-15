#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES=("zsh" "curl" "vim")

echo "$(tput setaf 6)Checking Installed Packages$(tput sgr0)"
for i in "${PACKAGES[@]}"; do
  dpkg -s $i &> /dev/null
  if [ $? -eq 0 ]; then
    echo "-> $i Installed"
  else
    echo -e "$(tput setaf 1)Install Failed\nPlease Install ${PACKAGES[@]}"
    exit 1
  fi
done

if [[ $1 = -w || $1 = --web ]]; then
  echo "$(tput setaf 6)Cloning the Dotfiles$(tput sgr0)"
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm ~/i3w &>/dev/null
fi

echo "$(tput setaf 6)Installing dotfiles$(tput sgr0)"
ln -sfv $DOTFILES_DIR/vim/vimrc ~/.vimrc
ln -sfv $DOTFILES_DIR/zsh/zshrc ~/.zshrc
ln -sfv $DOTFILES_DIR/X/xbindkeysrc ~/.xbindkeysrc
ln -sfv $DOTFILES_DIR/X/xmodmap ~/.xmodmap
ln -sfv $DOTFILES_DIR/tmux.conf ~/.tmux.conf

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

echo "$(tput setaf 6)Installing zsh$(tput sgr0)"
$DOTFILES_DIR/zsh/plugins/fzf/install

echo "$(tput setaf 6)Installing vim$(tput sgr0)"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +":PlugInstall" +qa
