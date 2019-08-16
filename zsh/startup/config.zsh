export FZF_DEFAULT_OPTS=' --prompt=">> " --color fg:-1,bg:-1,hl:208,fg+:-1,bg+:235,hl+:214 --color info:150,prompt:167,spinner:150,pointer:167,marker:0'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export KEYTIMEOUT=1
export VISUAL="vim"
export EDITOR="vim"
export PATH="$PATH:$HOME/i3wm/zsh/scripts/"
export TERMINAL="st"
export HIST_STAMPS="mm.dd.yyyy"
export HISTSIZE=12000
export SAVEHIST=12000
export HISTFILE="$HOME/.zsh_history"
export TERM="st-256color"
export VIM_YCM=false
export WORDCHARS='*?_-.[]~=&;!#%^(){}<>'
setopt prompt_subst
setopt promptsubst
setopt append_history
setopt extended_history
setopt sharehistory
setopt hist_reduce_blanks
setopt always_to_end
setopt complete_in_word
setopt auto_menu
setopt correct
setopt correctall
setopt noflowcontrol
setopt hist_verify
setopt list_packed
