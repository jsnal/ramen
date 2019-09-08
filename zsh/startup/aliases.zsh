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
alias cp='cp -v'
alias trash='mv -t /tmp/'
alias aa='sudo $(fc -ln -1)'
alias gotop='gotop --color=monokai'
alias myip="ip -color address"
alias crontab-all="crontab -l | grep -v '^#' | cut -f 6- -d ' ' | while read CMD; do eval $CMD; done"
alias j="jump"
alias paste-search="wget -qO- jasonlong24.crabdance.com/paste/posts.lst | sed 1,5d | grep -i "$1""
alias test_color="printf '\e[48;5;%dm ' {0..255}; printf '\e[0m \n'"
