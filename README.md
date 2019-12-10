# i3wm Config

My i3wm config, scripts and setup.

### Setup
- Recursively clone this repo into your home directory
- Run the installer.sh

or

```
bash <(wget -qO- https://raw.githubusercontent.com/jsnal/i3wm/master/install.sh)
```

### Install Script

The install script supports the following options:

```
-p, --profile [PROFILE]
    Change the install profile. Default terminal

-v, --verify-install
    Verify that all files and submodules are present

--git-user [USER]
    Set the git username in ~/.gitconfig

--git-email [EMAIL]
    Set the git email in ~/.gitconfig
```

List of install profiles:

```
all
    Installs configuration files for desktop and terminal
    
desktop
    Installs just configuration files for desktop
    
terminal
    Installs just configuration files for terminal

minimal
    Installs just zsh, vim, and tmux configuration files
```

### Secret Config

You can override some configuration settings in `zsh/startup/secret.zsh`

```
# vim autocomplete (coc)
_i3wm[vim_coc]='true'

# zsh color environment
_i3wm[color_env]='256'
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
- the-silver-searcher
    - A tool for quickly looking through code
    - [Install Package](https://www.archlinux.org/packages/community/x86_64/the_silver_searcher/)
