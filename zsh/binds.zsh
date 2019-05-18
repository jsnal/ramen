autoload -U edit-command-line
zle -N edit-command-line
function up_widget() {
      BUFFER="cd .."
      zle accept-line
}
zle -N up_widget

bindkey -s '^e' 'f -f\n'
bindkey -s '^h' 'd -f\n'
bindkey -s '^y' '. ~/.zshrc\nclear\n'
bindkey "^u" up_widget
bindkey '^w' forward-word
bindkey '^b' backward-word
bindkey '^d' kill-whole-line
bindkey '^k' backward-kill-word
bindkey '^j' kill-word
bindkey '^x^x' edit-command-line
