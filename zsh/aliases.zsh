# Short Pacman
alias pacup='sudo pacman -Sy && sudo abs && sudo aur'
alias pacls='pacman -Qi'
alias yaup='yay -Sy && sudo abs && sudo aur'
alias yals='yay -Qi'
alias yamir='yay -Syy'

alias tmuxn='tmux -2 new -s "$@"'
alias tmuxk='tmux kill-session -t "$@"'
alias tmuxa='tmux -2 a -t "$@"'

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
alias crontab-all="crontab -l | grep -v '^#' | cut -f 6- -d ' ' | while read CMD; do eval $CMD; done"

# Personal Plugins
export BM_CONFIG="$HOME/i3wm/zsh/plugins/shell-plugins/zshbookmarks/config.sh"
alias d="source $HOME/i3wm/zsh/plugins/shell-plugins/zshbookmarks/zshbookmark.sh -c $HOME/i3wm/zsh/.dirbookmarks dir"
alias f="source $HOME/i3wm/zsh/plugins/shell-plugins/zshbookmarks/zshbookmark.sh -c $HOME/i3wm/zsh/.filebookmarks file"
alias stagit-gen="$HOME/i3wm/zsh/plugins/shell-plugins/stagit-gen/gen.sh"
alias qp="git add --all && git commit  && git push $1 $(git branch 2>/dev/null | grep \* | sed -e 's/*[[:space:]]//g')"
