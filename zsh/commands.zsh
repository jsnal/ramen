# Resource all things zsh
function src() {
  local cache=$ZSH_CACHE_DIR
  autoload -U compinit zrecompile
  compinit -d "$cache/zcomp-$HOST"

  for f in ~/.zshrc "$cache/zcomp-$HOST"; do
  	zrecompile -p $f && command rm -f $f.zwc.old
  done

  source ~/.zshrc
}

# One command to extract all
function extract {
  echo Extracting $1 ...
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xjf $1  ;;
          *.tar.gz)    tar xzf $1  ;;
          *.bz2)       bunzip2 $1  ;;
          *.rar)       unrar x $1    ;;
          *.gz)        gunzip $1   ;;
          *.tar)       tar xf $1   ;;
          *.tbz2)      tar xjf $1  ;;
          *.tgz)       tar xzf $1  ;;
          *.zip)       unzip $1   ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1  ;;
          *)        echo "'$1' cannot be extracted via extract()" ;;
      esac
  else
      echo "'$1' is not a valid file"
  fi
}

# Test internet connect with a ping test and speedtest
function net() {
  if [ -p = $1 ]
  then
    printf "Pinging Google.com... \n"
    ping -c 5 google.com | awk 'NR==2,NR==6{print $8}' | cut -c 6-
    printf "Pinging 8.8.8.8... \n"
    ping -c 5 8.8.8.8 | awk 'NR==2,NR==6{print $7}' | cut -c 6-
		printf '\n'
		ip addr
  elif [ -s = $1 ]
  then
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -
		printf '\n'
		ip addr
  else
    printf "Error... "
  fi
}

# Bundle and encrypt a directory with a gpg recipient.
function ebackup() {
  if [ $1 = "-h" ]; then echo 'ebackup [DIR] [RECIPIENT]' && return 0; fi
  if [ ! -d $1 ]; then echo $1 'is not a directory.' && return 1; fi
  echo 'Encrypting' $1
  local date=$(date +%D | sed 's/\//-/g')
  tar -cz $1 | gpg --recipient $2 -e -o $1\-$date.tgz.gpg
}

# Uncompress and decrypt a directory for a gpg recipient.
function dbackup() {
  if [ $1 = "-h" ]; then echo 'dbackup [FILE]' && return 0; fi
  if [ ! -f $1 ]; then echo $1 'is not a file.' && return 1; fi
  echo 'Decrypting' $1 '.tgz.gpg'
  gpg -d $1 | tar xz
}

# Send and create a new paste at jasonlong24.crabdance.com/paste
function paste-send() {
  local SEND_OUTPUT_HOST="jasonlong24.crabdance.com"
  local SEND_OUTPUT_PORT="2757"
  if [ ! -f $1 ]; then echo "$1 is not a valid file."; return 1; fi
  read "?Please enter a title: " entryTitle && read "?Please enter the date: " entryDate && read "?Please enter a filetype: " entryFT
  echo -e "//*title=$entryTitle\n//*date=$entryDate\n//*filetype=$entryFT" | cat - $1 | nc -v -q 0 $SEND_OUTPUT_HOST $SEND_OUTPUT_PORT
  echo "File Sent!"
}

# For checking local package on a failed command.
# https://wiki.archlinux.org/index.php/Zsh#The_%22command_not_found%22_hook
command_not_found_handler() {
  local pkgs cmd="$1"

  pkgs=(${(f)"$(pkgfile -i -b -- "$cmd" 2>/dev/null)"})
  if [[ -n "$pkgs" ]]; then
    printf '%s may be found in the following packages:\n' "$cmd"
    printf '  %s\n' $pkgs[@]
    return 0
  fi

  printf 'zsh: command not found: %s\n' "$cmd" 1>&2
  return 127
}

# Dump vim startup statistics.
function vim-dump() {
  vim --cmd 'profile start profile.log' \
    --cmd 'profile func *' \
    --cmd 'profile file *' \
    -c 'profdel func *' \
    -c 'profdel file *' \
    -c 'qa!'
}

# Merge my zshrc and zsh/ files together.
function zsh-minify() {
  local OUT=$1
  [ -z $1 ] && local OUT="./zshrc.min"
  if [ -d $HOME/i3wm ]; then
    git -C $HOME/i3wm pull origin master
    cat $HOME/i3wm/zsh/zshrc.min > $OUT
    cat $HOME/i3wm/zsh/*.zsh >> $OUT
  fi
}

# Merge my vimrc and vim/startup files together.
function vim-minify() {
  local OUT=$1
  [ -z $1 ] && local OUT="./vimrc.min"
  if [ -d $HOME/i3wm ]; then
    git -C $HOME/i3wm pull origin master
    cat $HOME/i3wm/vim/vimrc > $OUT
    find $HOME/i3wm/vim/startup -maxdepth 1 -iname '*.vim' -not -name 'functions.vim' -exec cat {} +>> $OUT
  fi
}

function caln() {
  if [ -z $1 ]; then local months="3"; else; local months="$1"; fi
  cal -n $months
}

# Simple coutdown timer.
function countdown(){
  date1=$((`date +%s` + $1));
  while [ "$date1" -ge `date +%s` ]; do
    echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
  done
  printf '\aTimer Done!'
}

# Create a temporary directory and enter a new shell
function scratch() {
  local SCRATCH=$(mktemp -d)
  echo -e "Opening temporary shell:\n\t$SCRATCH"
  (cd $SCRATCH; zsh)
  echo "Removing scratch directory"
  rm -r "$SCRATCH"
}
