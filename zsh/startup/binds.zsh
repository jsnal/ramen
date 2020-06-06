# Set emacs binds
bindkey -e

# Turn on the edit command line widget. See binding at the bottom.
autoload -U edit-command-line
zle -N edit-command-line

# Bail out if not interactive shell.
[[ -o interactive  ]] || return 0

# cd backwards
function cd-back() {
  BUFFER="cd .."
  zle accept-line
}
zle -N cd-back
bindkey "^u" cd-back

# Reattach to a backgrounded process if it exists.
function smart-fg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N smart-fg
bindkey '^z' smart-fg

# Helper function for finding files and piping them into fzy
function __fsel() {
  if command -v rg >/dev/null 2>&1; then
    local cmd="command rg --files --color never"
  else
    local cmd="command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
      -o -type f -print \
      -o -type l -print 2> /dev/null | cut -b3-"
  fi
  setopt localoptions pipefail no_aliases 2> /dev/null
  eval $cmd | fzy $FZY_DEFAULT_OPTS | read item && echo -n "$1 $item"
}

# Fuzzy find for files
function fuzzy-file() {
  echo -e '\nLoading...'
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle beginning-of-line
  zle reset-prompt
  return $ret
}
zle -N fuzzy-file

# Fuzzy find for files to edit
function fuzzy-edit() {
  echo -e '\nLoading...'
  zle kill-whole-line
  LBUFFER="${LBUFFER}$(__fsel vim)"
  local ret=$?
  zle accept-line
  zle reset-prompt
  return $ret
}
zle -N fuzzy-edit

# Fuzzy search through zsh history
function fuzzy-history() {
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  local choice=$(fc -rl 1 | fzy $FZY_DEFAULT_OPTS)
  local ret=$?
  if [ ! -z $choice ]; then
    zle vi-fetch-history -n $choice
  fi
  zle reset-prompt
  return $ret
}
zle -N fuzzy-history

# If fzy is not installed, don't waste time setting up the bindings. This way I
# can still use the built in keybindings that fzy overrides by default.
if [ $(command -v fzy) ]; then
  bindkey '^t' fuzzy-file
  bindkey '^f' fuzzy-edit
  bindkey '^r' fuzzy-history
else
  echo 'Unable to find fzy. Removing fzy bindings...'
fi

# General Keybinds
bindkey '^w' forward-word
bindkey '^b' backward-word
bindkey '^d' kill-whole-line
bindkey '^k' backward-kill-word
bindkey '^j' kill-word
bindkey '^x^x' edit-command-line
