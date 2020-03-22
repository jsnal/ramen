# Short tmux
alias tmuxn='tmux -2 new -s "$@"'
alias tmuxk='tmux kill-session -t "$@"'
alias tmuxa='tmux -2 a -t "$@"'

# Eaiser Backwards cd
alias ..1='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'

# System command aliases
alias v='vim'
alias vi='vim'
alias z='zathura'
alias j="jump"
alias ls='ls --color=always --group-directories'
alias ll='ls --color=always --group-directories'
alias l='ls'
alias cp='cp -v'
alias trash='mv -t /tmp/'
alias aa='sudo $(fc -ln -1)'
alias myip="ip -color address"

# Improvement of life commands
alias crontab_all="crontab -l | grep -v '^#' | cut -f 6- -d ' ' | while read CMD; do eval $CMD; done"
alias paste_search='wget -qO- jasonlong.xyz/paste/posts.list | sed 1,5d | grep -i "$@"'
alias test_color="printf '\e[48;5;%dm ' {0..255}; printf '\e[0m \n'"
alias config_version="git --git-dir ~/i3wm/.git rev-parse HEAD"

# Exceptions to auto-correction
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'
