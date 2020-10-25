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
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias z='zathura'
alias j="jump"
alias l='ls'
alias cp='cp -v'
alias trash='mv -t /tmp/'

# Only make these system mappings on Linux
if [ "$(uname 2> /dev/null)" = "Linux" ]; then
  alias aa='sudo $(fc -ln -1)'
  alias myip="ip -color address"
  alias ls='ls --color=always --group-directories'
  alias ll='ls -la --color=always --group-directories'
fi

# Improvement of life commands
alias crontab_all="crontab -l | grep -v '^#' | cut -f 6- -d ' ' | while read CMD; do eval $CMD; done"
alias test_color="printf '\e[48;5;%dm ' {0..255}; printf '\e[0m \n'"
alias config_version="git --git-dir $_ramen[ramen_home]/.git rev-parse HEAD"

# Exceptions to auto-correction
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'
alias docker='nocorrect docker'
alias jump='nocorrect jump'
