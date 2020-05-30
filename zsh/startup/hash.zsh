# Inspired from: https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.zsh/hash
() {
  local SITE=/var/www/html
  local PORTAL=~/git/portal
  local SERAPE=~/.vim/plugged/vim-serape
  local CHORE=~/.vim/plugged/vim-chore
  local RAMEN=$_ramen[ramen_home]
  local ZSH=$_ramen[ramen_home]/zsh
  local VIM=$_ramen[ramen_home]/vim
  local GIT=~/git

  test -d "$SITE" && hash -d site="$SITE"
  test -d "$PORTAL" && hash -d portal="$PORTAL"
  test -d "$SERAPE" && hash -d serape="$SERAPE"
  test -d "$CHORE" && hash -d chore="$CHORE"
  test -d "$RAMEN" && hash -d ramen="$RAMEN"
  test -d "$ZSH" && hash -d zsh="$ZSH"
  test -d "$VIM" && hash -d vim="$VIM"
  test -d "$GIT" && hash -d git="$GIT"
}

# Quickly skim through all child directories and put them into std out
#
# Note: programs like ag and rg should probably be used here but they
#       both require you to install something
function fd() {
  local DIR="$1"
  [ -z $DIR ] && DIR="."
  find . -type d | grep $DIR
}

# Jump to a directory via hash
function jump() {
  emulate -L zsh

  if [ $# -eq 0 ]; then
    local DIR_FD=$(fd | fzy $FZY_DEFAULT_OPTS)

    # If it is empty assume the command was cancelled
    [ -z $DIR_FD ] && return 1
    cd $DIR_FD
  else

    if [ $1 = "-l" ] || [ $1 = "--list" ]; then
      hash -d | sed 's/=/ -> /g' | column -t  && return 1
    fi

    local DIR="$1"
    if [ $(hash -d | cut -d= -f1 | grep -c "^${DIR}\$") = 0 ]; then
      echo "Searching for instances of $1..."
      local DIR_FD=$(fd $1)

      # Check that fd actually found something
      [ -z $DIR_FD ] && echo "$1 not found anywhere" && return 1
      cd $(echo $DIR_FD | fzy $FZY_DEFAULT_OPTS)
    else
      cd ~"$DIR"
    fi
  fi
}
