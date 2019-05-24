function viz { vim $(fzf) }

function vif() {
    i3 fullscreen toggle & vim "$@"
    clear
}

function src() {
  local cache=$ZSH_CACHE_DIR
  autoload -U compinit zrecompile
  compinit -d "$cache/zcomp-$HOST"

  for f in ~/.zshrc "$cache/zcomp-$HOST"; do
  	zrecompile -p $f && command rm -f $f.zwc.old
  done

  source ~/.zshrc
}

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

function os() {
  screenfetch | grep -o 'OS:.*'
}

function forcast() {
        curl wttr.in/"$@"
}

function net() {
  if [ -l = $1 ]
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

function comp-type() {
	type=$(ls /sys/class/power_supply | grep BAT)

	if [ "$type" != "BAT0" ]; then
		echo "desktop"
	else
		echo "laptop"
	fi
}

function playdoom() {
  poss=$(ls /usr/share/games/doom/ | nl -w2)
  echo -e "$poss"\n
  echo Pick the wad you want to play.
  read wad
  play=$(ls /usr/share/games/doom/ | awk NR==$wad)
  echo $play
  i3-msg move scratchpad
  prboom-plus -iwad /usr/share/games/doom/$play
}

function mdc() {
  if [ -d = "$1" ]
  then
    rm "$2"
    pandoc --mathjax --toc -o "$2" "$3"/*.md
    evince "$2"
	elif [ -f = "$1" ]; then
		rm "$2"
		pandoc --mathjax --toc -o "$2" "$3"
		zathura "$2"
  else
    echo "Usage: mdc [OPTION] <Output Path> <Directory>"
  fi
}

function kernel-update() {
	latest=$(w3m -dump kernel.ubuntu.com/~kernel-ppa/mainline/ | tail -5 | awk 'FNR == 1 {print $2}')
	echo -n "Version "$latest" (y/n)? "
	read answer
	if echo "$answer" | grep -iq "^y" ;then
  	  echo Yes
	rm -r ~/.kernel-deb/*.deb
  headersall=$(w3m -dump http://kernel.ubuntu.com/\~kernel-ppa/mainline/"$latest" | awk '{print $3}' | awk '/headers/ && /generic/ && /amd64/')
	echo "\n--> Headers amd64 found "$headersall""
  headersamd64=$(w3m -dump http://kernel.ubuntu.com/\~kernel-ppa/mainline/"$latest" | awk '{print $3}' | awk '/headers/ && /all/')
	echo "\n--> Headers all found "$headersamd64""
  image=$(w3m -dump http://kernel.ubuntu.com/\~kernel-ppa/mainline/"$latest" | awk '{print $3}' | awk '/image/ && /generic/ && /amd64/')
	echo "\n--> Image found "$image""
	echo "\n"
	wget -P ~/.kernel-deb http://kernel.ubuntu.com/~kernel-ppa/mainline/"$latest""$headersall" http://kernel.ubuntu.com/~kernel-ppa/mainline/"$latest""$headersamd64" http://kernel.ubuntu.com/~kernel-ppa/mainline/"$latest""$image"
	echo "\n--> Installing kernel version "$latest""
	sudo dpkg -i ~/.kernel-deb/*.deb
	else
    	echo No
	fi
}

function encrypt() {
  if [[ -d = $1 ]]; then
    gpg -d $2 | tar xz
  else
    tar -cz $1 | gpg -c -o $1.tgz.gpg
  fi
}

function vl() {
  case $1 in
    up) amixer -q sset "Master" $2%+ && echo $(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master));;
  down) amixer -q sset "Master" $2%- && echo $(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master));;
   off) amixer set "Master" 0% && echo "Muted"
  esac
}

function ebackup() {
  if [ $1 = "-h" ]; then echo 'ebackup [DIR] [RECIPIENT]' && return 0; fi
  if [ ! -d $1 ]; then echo $1 'is not a directory.' && return 1; fi
  echo 'Encrypting' $1
  local date=$(date +%D | sed 's/\//-/g')
  tar -cz $1 | gpg --recipient $2 -e -o $1\-$date.tgz.gpg
}

function dbackup() {
  if [ $1 = "-h" ]; then echo 'dbackup [FILE]' && return 0; fi
  if [ ! -f $1 ]; then echo $1 'is not a file.' && return 1; fi
  echo 'Decrypting' $1 '.tgz.gpg'
  gpg -d $1 | tar xz
}

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
