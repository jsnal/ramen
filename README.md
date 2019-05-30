# i3wm Config

 My i3wm config, scripts and setup.

### Setup
- Recursively clone this repo into your home directory
- Run the installer.sh

or

```
bash <(wget -qO- https://raw.githubusercontent.com/jsnal/i3wm/master/install.sh)
```

### Minified Config

- Install minified configs from [here](http://jasonlong24.crabdance.com/min/)

```
# zsh
wget -O ~/.zshrc http://jasonlong24.crabdance.com/min/zshrc.min

# vim
wget -O ~/.vimrc http://jasonlong24.crabdance.com/min/vimrc.min && test -e ~/.vim/autoload/plug.vim || (mkdir -p ~/.vim/autoload; curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) && vim +PlugInstall +qall
```

### Secret Config

```
# vim autocomplete
export VIM_YCM=true
```

### Tools
- i3
    - Tiling window manager for Xorg
    - [Install Package](https://github.com/i3/i3)
- dmenu
    - Fuzzy Finder for applications and other things.
    - [Install Package](https://git.suckless.org/dmenu/)
- zsh
    - Replacement for bash.
    - [Install package](https://www.archlinux.org/packages/extra/x86_64/zsh/)
- lemonbar
    - Replacement for i3Blocks but I still use some of the i3Block scripts
    - [Install Package](https://github.com/jaagr/polybar)
- st
    - Terminal emulator written in 32k lines of C code.
    - [Install Package](https://git.suckless.org/st/)
- vim
    - Modal based text editor.
    - [Install Package](https://github.com/vim/vim)
- zathura
    - Minimal pdf viewer
    - [Install Package](https://www.archlinux.org/packages/community/x86_64/zathura/)
    - [Install PDF Plugin](https://www.archlinux.org/packages/community/x86_64/zathura-pdf-mupdf/)
- dunst
    - Minimal notification displayer
    - [Install Package](https://www.archlinux.org/packages/community/x86_64/dunst/)
- fzf
    - light and fast fuzzy file finder
    - [Install Package](https://www.archlinux.org/packages/community/x86_64/dunst/)

### Testing

To be sure that each push will work on a fresh install of linux, I use a docker container with Ubuntu 18.04, which builds on a Jenkins server.
