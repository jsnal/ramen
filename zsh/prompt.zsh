# command time partly from: https://github.com/popstas/zsh-command-time

function preexec() {
  timer=${timer:-$SECONDS}
  ZSH_COMMAND_TIME_MSG=${ZSH_COMMAND_TIME_MSG-"%s"}
  export ZSH_COMMAND_TIME=""
}

function precmd {

  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export ZSH_COMMAND_TIME="$timer_show"
    if [ ! -z ${ZSH_COMMAND_TIME_MSG} ]; then
      zsh_command_time
    fi
    unset timer
  fi

  function get_trailing_symbol() {
    if sudo -n true 2>/dev/null; then
      end_symbol="$SUDO#"
    else
      end_symbol="$"
    fi
  }
  get_trailing_symbol

  if [ $? -eq 0  ]; then
    END="$PROMPTC${end_symbol}%(1j.*.) "
  else
    END="$ALTPROMPT${end_symbol}$PROMPTC%(1j.*.) "
  fi

  BRACKET="%{%F{white}%}"
  SUDO="%{%F{red}%}"
  DIR="%{%F{cyan}%}"
  PROMPTC="%{%F{white}%}"
  CUSER="%{%F{yellow}%}"
  GIT_BRANCH="%{%F{magenta}%}"
  ALTPROMPT="%{%F{red}%}"

  DIR="[$DIR%B%(5~|../%3~|%~)%b$BRACKET$BRACKET]% "
  CUSER="$BRACKET@$CUSER%n"

  PROMPT="$CUSER$BRACKET$DIR$END%{$reset_color%}%"
  RPROMPT="%F{8}${timer_show}%F{white}%}$(git_full_prompt)"
}

zsh_command_time() {
  if [ -n "$ZSH_COMMAND_TIME" ]; then
    hours=$(($ZSH_COMMAND_TIME/3600))
    min=$(($ZSH_COMMAND_TIME/60))
    sec=$(($ZSH_COMMAND_TIME%60))
    if [ "$ZSH_COMMAND_TIME" -le 60 ]; then
      timer_show="${ZSH_COMMAND_TIME}s "
    elif [ "$ZSH_COMMAND_TIME" -gt 60 ] && [ "$ZSH_COMMAND_TIME" -le 180 ]; then
      timer_show="${min}min ${sec}s "
    else
      if [ "$hours" -gt 0 ]; then
        min=$(($min%60))
        timer_show="${hours}h ${min}min ${sec}s "
      else
        timer_show="${min}min ${sec}s "
      fi
    fi
  fi
}

export SPROMPT="%B%F{red}'%R'%b%f -> %B%F{red}'%r'%b%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "
