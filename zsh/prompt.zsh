function precmd {

  if [ $? -eq 0  ]; then
    END="$PROMPTC$%(1j.*.) "
  else
    END="$ALTPROMPT\$$PROMPTC%(1j.*.) "
  fi

  function get_sudo() {
    if sudo -n true 2>/dev/null; then
      echo "sudo"
    else
      echo ""
    fi
  }

  BRACKET="%{%F{white}%}"
  SUDO="%{%F{red}%}"
  DIR="%{%F{cyan}%}"
  PROMPTC="%{%F{white}%}"
  USER="%{%F{yellow}%}"
  GIT_BRANCH="%{%F{magenta}%}"
  ALTPROMPT="%{%F{red}%}"

  DIR="[$DIR%B%(5~|../%3~|%~)%b$BRACKET$BRACKET]% "
  USER="$BRACKET@$USER%n"

  PROMPT="$SUDO$(get_sudo)$USER$BRACKET$DIR$END%{$reset_color%}%"
  RPROMPT="$(git_full_prompt)"
}
