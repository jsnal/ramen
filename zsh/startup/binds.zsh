bindkey -e # emacs binds

autoload -U edit-command-line
zle -N edit-command-line

# Easy backwards cd
function up_widget() {
  BUFFER="cd .."
  zle accept-line
}
zle -N up_widget

# Bind to reattach to a backgrounded process if it exists.
function smart-fg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N smart-fg

# Easy way to fzf in commonly used directories.
function fzf-edit() {
  local choice=$(find . -maxdepth 3 -type f -printf '%P\n' | fzf)
  if [ ! -z $choice ]; then
    vim $choice
  fi
}
zle -N fzf-edit

bindkey -s '^f' 'fzf-edit^M'
bindkey -s '^y' '. ~/.zshrc^Mclear^M'
bindkey "^u" up_widget
bindkey '^w' forward-word
bindkey '^b' backward-word
bindkey '^d' kill-whole-line
bindkey '^k' backward-kill-word
bindkey '^j' kill-word
bindkey '^z' smart-fg
bindkey '^x^x' edit-command-line
