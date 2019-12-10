# command time partly from: https://github.com/popstas/zsh-command-time

function preexec() {
  timer=${timer:-$SECONDS}
  export ZSH_COMMAND_TIME=""
}

function precmd {

  _i3wm[LAST_EXIT_CODE]=$?
  local END=""

  # Sudo shell
  if sudo -n true 2>/dev/null; then
    TRAILING_SYMBOL="$_i3wm[RED]#$_i3wm[WHITE]"
  else
    TRAILING_SYMBOL="$_i3wm[WHITE]%%"
  fi

  # Error code and backgrounded tasks
  if [ $_i3wm[LAST_EXIT_CODE] -eq 0 ]; then
    END="$TRAILING_SYMBOL%(1j.*.) "
  elif [ $_i3wm[LAST_EXIT_CODE] -eq 1 ]; then
    END="$TRAILING_SYMBOL%B$_i3wm[ORANGE]!$_i3wm[WHITE]%b%(1j.*.) "
  else
    END="%(1j.*.) %B$_i3wm[ORANGE]$_i3wm[LAST_EXIT_CODE]$_i3wm[WHITE]%b $TRAILING_SYMBOL "
  fi

  if [ $timer ]; then
    _i3wm[COMMAND_TIME]=$(($SECONDS - $timer))
    export ZSH_COMMAND_TIME="$_i3wm[COMMAND_TIME]"
    zsh_command_time
    unset timer
  fi

  local DIR="$_i3wm[CYAN]%B%(5~|../%3~|${${PWD/#%$HOME%/\~\/}/#$HOME/~})%b$_i3wm[WHITE]%"
  local CUSER="$_i3wm[WHITE]@$_i3wm[YELLOW]%n"

  PROMPT="${CUSER}$_i3wm[WHITE]${END}$_i3wm[WHITE]"
  RPROMPT="$_i3wm[GRAY]${_i3wm[COMMAND_TIME]}$_i3wm[WHITE]$(git_prompt_info) ${DIR}"
}

zsh_command_time() {
  if [ -n "$ZSH_COMMAND_TIME" ]; then
    hours=$(($ZSH_COMMAND_TIME/3600))
    min=$(($ZSH_COMMAND_TIME/60))
    sec=$(($ZSH_COMMAND_TIME%60))
    if [ "$ZSH_COMMAND_TIME" -le 1 ]; then
      _i3wm[COMMAND_TIME]=""
    elif [ "$ZSH_COMMAND_TIME" -le 60 ]; then
      _i3wm[COMMAND_TIME]="${ZSH_COMMAND_TIME}s "
    elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
      _i3wm[COMMAND_TIME]="${min}min ${sec}s "
    else
      if [ "$hours" -gt 0 ]; then
        min=$(($min%60))
        _i3wm[COMMAND_TIME]="%B$_i3wm[RED]${hours}h%b$_i3wm[GRAY] ${min}min ${sec}s "
      else
        _i3wm[COMMAND_TIME]="${min}min ${sec}s "
      fi
    fi
  fi
}

export SPROMPT="%B%F{red}'%R'%b%f -> %B%F{red}'%r'%b%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
