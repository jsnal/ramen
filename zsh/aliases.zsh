# Keyboard Shortcuts {{{
bindkey -s '^e' 'f -f\n'
bindkey -s '^h' 'd -f\n'
bindkey -s '^y' '. ~/.zshrc\nclear\n'
bindkey -s '^n' './tg/bin/telegram-cli -W -N\n'
bindkey -s '^f' 'vim $(fzf\n'
function up_widget() {
      BUFFER="cd .."
      zle accept-line
}
zle -N up_widget
bindkey "^u" up_widget
bindkey '^w' forward-word
bindkey '^b' backward-word
bindkey '^d' kill-whole-line
bindkey -r "^k"
bindkey '^k' backward-kill-word
# }}}
# Package Manager {{{
function aptup() { sudo apt-get update }
function aptupgr() { sudo apt-get upgrade }
function aptcln() { sudo apt-get clean }
function aptinst() { sudo apt-get install "$1" }
function aptprg() { sudo apt-get purge "$1" }
function aptshow() { sudo apt-cache show "$1" }
function aptdep() { sudo apt-cache showpkg "$1" }
# Pacman
function pacup() { sudo pacman -Sy && sudo abs && sudo aur }
function pacls() { pacman -Qi }
function yaup() { yaourt -Sy && sudo abs && sudo aur }
function yals() { yaourt -Qi }
function yamir() { yaourt -Syy }
# }}}

function tmuxn() { tmux -2 new -s "$@" }
function tmuxk() { tmux kill-session -t "$@" }
function tmuxa() { tmux -2 a -t "$@" }

# Eaiser Backwards cd
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

alias v='vim'
alias z='zathura'
alias ls='ls -Fh --color=always --group-directories'
alias ll='ls -hl --color=always --group-directories'
alias l='ls'
alias aa='sudo $(fc -ln -1)'
alias gotop='gotop --color=monokai'
alias tll='~/i3wm/i3/Scripts/tll.sh l'
alias tlc='~/i3wm/i3/Scripts/tll.sh c "$@"'
alias tla='~/i3wm/i3/Scripts/tll.sh a "$@"'
alias drivec="~/i3wm/zsh/scripts/drive-compile.sh"
alias myip="ip -color address"
export BM_CONFIG="$HOME/i3wm/zsh/plugins/shell-plugins/zshbookmarks/config.sh"
alias d="source $HOME/i3wm/zsh/plugins/shell-plugins/zshbookmarks/zshbookmark.sh -c $HOME/i3wm/zsh/.dirbookmarks dir"
alias f="source $HOME/i3wm/zsh/plugins/shell-plugins/zshbookmarks/zshbookmark.sh -c $HOME/i3wm/zsh/.filebookmarks file"
alias stagit-gen="$HOME/i3wm/zsh/plugins/shell-plugins/stagit-gen/gen.sh"
alias qp="git add --all && git commit  && git push $1 $(git branch 2>/dev/null | grep \* | sed -e 's/*[[:space:]]//g')"
alias xmod-caps="xmodmap $HOME/.Xmodmap"
