# i3wm Config

My configuration files for linux.

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
bash <(wget -qO- https://raw.githubusercontent.com/jsnal/i3wm/master/install.sh)
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
allInstalls       configuration files for desktop and terminal
desktopInstalls   just configuration files for desktop
terminalInstalls  just configuration files for terminal
```

### Local Configuration

You can override some default configuration in `~/.zshrc.local`

```
# removes some unnecessary vim plugins
_i3wm[vim_lite]='true'

# zsh color environment
_i3wm[color_env]='256'
```

## Useful programs

- [ag](https://geoff.greer.fm/ag/) to quickly search through code.
- [fzf](https://github.com/junegunn/fzf) for fuzzy file searches.
- [dmenu](https://tools.suckless.org/dmenu/) to search for programs and other things.
