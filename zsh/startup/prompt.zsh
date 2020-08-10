# command time partly from: https://github.com/popstas/zsh-command-time

function preexec() {
  timer=${timer:-$SECONDS}
  export ZSH_COMMAND_TIME=""
}

function precmd {

  _ramen[LAST_EXIT_CODE]=$?
  local END=""

  # Sudo shell
  if sudo -n true 2>/dev/null; then
    TRAILING_SYMBOL="$_ramen[RED]#$_ramen[WHITE]"
  else
    TRAILING_SYMBOL="$_ramen[WHITE]%%"
  fi

  # Error code and backgrounded tasks
  if [ $_ramen[LAST_EXIT_CODE] -eq 0 ]; then
    END="$TRAILING_SYMBOL%(1j.*.) "
  elif [ $_ramen[LAST_EXIT_CODE] -eq 1 ]; then
    END="$TRAILING_SYMBOL%B$_ramen[ORANGE]!$_ramen[WHITE]%b%(1j.*.) "
  else
    END="%(1j.*.) %B$_ramen[ORANGE]$_ramen[LAST_EXIT_CODE]$_ramen[WHITE]%b $TRAILING_SYMBOL "
  fi

  if [ $timer ]; then
    _ramen[COMMAND_TIME]=$(($SECONDS - $timer))
    export ZSH_COMMAND_TIME="$_ramen[COMMAND_TIME]"
    zsh_command_time
    unset timer
  fi

  local DIR="$_ramen[CYAN]%B%(5~|../%3~|${${PWD/#%$HOME%/\~\/}/#$HOME/~})%b$_ramen[WHITE]%"
  local CUSER="$_ramen[WHITE]@$_ramen[YELLOW]%n"

  PROMPT="${CUSER}$_ramen[WHITE]${END}$_ramen[WHITE]"
  RPROMPT="$_ramen[GRAY]${_ramen[COMMAND_TIME]}$_ramen[WHITE]$(git_prompt_info) ${DIR}"
}

zsh_command_time() {
  if [ -n "$ZSH_COMMAND_TIME" ]; then
    hours=$(($ZSH_COMMAND_TIME/3600))
    min=$(($ZSH_COMMAND_TIME/60))
    sec=$(($ZSH_COMMAND_TIME%60))
    if [ "$ZSH_COMMAND_TIME" -le 1 ]; then
      _ramen[COMMAND_TIME]=""
    elif [ "$ZSH_COMMAND_TIME" -le 60 ]; then
      _ramen[COMMAND_TIME]="${ZSH_COMMAND_TIME}s"
    elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
      _ramen[COMMAND_TIME]="${min}min ${sec}s"
    else
      if [ "$hours" -gt 0 ]; then
        min=$(($min%60))
        _ramen[COMMAND_TIME]="%B$_ramen[RED]${hours}h%b$_ramen[GRAY] ${min}min ${sec}s"
      else
        _ramen[COMMAND_TIME]="${min}min ${sec}s"
      fi
    fi
  fi
}

export SPROMPT="%B%F{red}'%R'%b%f -> %B%F{red}'%r'%b%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
