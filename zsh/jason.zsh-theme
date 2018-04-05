BRACKET="%{$fg[white]%}"
SUDO="%{$fg[red]%}"
DIR="%{$fg[cyan]%}"
PROMPT="%{$fg_bold[white]%}"
USER="%{$fg[yellow]%}"
GIT_BRANCH="%{$fg[green]%}"
GIT_CLEAN="%{$fg[green]%}"
GIT_DIRTY="%{$fg[red]%}"

ZSH_THEME_GIT_PROMPT_PREFIX="$BRACKET:$BRACKET"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN●"
ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY●"

function get_sudo() {
	if sudo -n true 2>/dev/null; then 
  	 echo "sudo" 
	else
  	 echo "" 
	fi
}

DIR="[$DIR%~\$(git_prompt_info)$BRACKET]% "
USER="$BRACKET@$USER%m"
END="$PROMPT$ "

PROMPT="$SUDO$(get_sudo)$USER$BRACKET$DIR$END%{$reset_color%}%"
