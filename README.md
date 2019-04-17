# i3wm Config [![Build Status](http://jasonlong24.crabdance.com:8080/buildStatus/icon?job=i3wm/master)](http://jasonlong24.crabdance.com:8080/job/i3wm/job/master/)

 My i3wm config, scripts and setup.

 vim [Snippets](https://github.com/JasonLong24/snippets)
### Setup
- Clone this repo into your home directory
- Run the installer.sh

or

```
bash <(wget -qO- https://raw.githubusercontent.com/jsnal/i3wm/master/install.sh)
```

### Minified Config

- Install minified configs from [here](http://jasonlong24.crabdance.com/min/)

```
wget -O ~/.zshrc http://jasonlong24.crabdance.com/min/zshrc.min
```

### Secret Config

- Add secret.zsh to $HOME/zsh
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

### Testing

To be sure that each push will work on a fresh install of linux, I use a docker container with Ubuntu 18.04, which builds on a Jenkins server.

[![Build Status](http://jasonlong24.crabdance.com:8080/buildStatus/icon?job=i3wm/master)](http://jasonlong24.crabdance.com:8080/job/i3wm/job/master/)
