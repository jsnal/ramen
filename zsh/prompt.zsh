function precmd {
  AltPrompt=null
  BRACKET="%F{white}"
  SUDO="%F{red}"
  DIR="%F{cyan}"
  PROMPT="%F{white}"
  USER="%F{yellow}"
  GIT_BRANCH="%F{magenta}"
  ALTPROMPT="%F{red}"

  # Functions# {{{
  function get_sudo() {
    if sudo -n true 2>/dev/null; then 
      echo "sudo" 
    else
      echo "" 
    fi
  }

  case $AltPrompt in
    tmux)
      session="("$(tmux ls | wc -l)")" ;;
    cpu)
      session="("$(top -bn 1 | grep "Cpu" | awk '{print $2}')")" ;;
    mem)
      session="("$(free -m | awk 'NR==2{print $3}')")" ;;
    hist)
      session="("$(history | cut -d " " -f4-15 | tail -1)")" ;;
    hist-num)
      session"("$(history | cut -d " " -f2)")" ;;
    *)
      session="" ;;
  esac

  #  RPROMPT="$ALTPROMPT%B${session}%b"
  DIR="[$DIR%B%~%b$(git_full_prompt)$BRACKET]% "
  USER="$BRACKET@$USER%m"
  END="$PROMPT$ "

  PROMPT="$SUDO$(get_sudo)$USER$BRACKET$DIR$END%{$reset_color%}%"
}
