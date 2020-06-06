# Dotfiles

ramen holds all of my configuration files for linux.

## Dependencies

- [tmux](http://tmux.sourceforge.net/) 2.3 or later.
- [vim](http://www.vim.org/) 8.0 or later with Python support.
- recent [zsh](http://www.zsh.org/).
- recent [git](http://git-scm.com/).
- recent [i3](https://i3wm.org/).

## Installation

### Manual

- Recursively clone this repository into your home directory.
- Run the install.sh

### Automated

```
bash <(wget -qO- https://raw.githubusercontent.com/jsnal/ramen/master/install.sh)
```

### Install options

The install script supports the following options.

```
-p, --profile [PROFILE]   Change the install profile. Default terminal
--git-user [USER]         Set the git username in ~/.gitconfig
--git-email [EMAIL]       Set the git email in ~/.gitconfig
```

### Install profiles

The install script supports the following install profiles.

```
all        Installs configuration files for desktop and terminal
desktop    Installs just configuration files for desktop
terminal   Installs just configuration files for terminal
```

### Local Configuration

You can override some default configuration in `~/.zsh/.zshrc.local`

```
# removes some unnecessary vim plugins
_ramen[vim_lite]='true'

# zsh color environment
_ramen[color_env]='256'
```

## Useful programs

- [rg](https://github.com/BurntSushi/ripgrep) to quickly search through code.
- [fzy](https://github.com/jhawthorn/fzy) for fuzzy text searches.
- [dmenu](https://tools.suckless.org/dmenu/) to search for programs and other things.
