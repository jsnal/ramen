#!/usr/bin/env zsh

red="%{%F{red}%}"
green="%{%F{green}%}"
orange="%{%F{214}%}"
reset="%{%F{white}%}"

function dot_git() {
  dot_git="$(git rev-parse --git-dir 2>/dev/null)"
  printf '%s' $dot_git
}

function is_repo() {
  if [[ -n "$(dot_git)" ]]; then
    return 0
  else
    return 1
  fi
}

# Get branch info in a format similar to $ git status -sb
function get_branch() {
  local local_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @ 2>/dev/null)
  local upstream_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

  if [ -z $upstream_branch ]; then

    # Check if you're attached to a branch
    git symbolic-ref HEAD &>/dev/null
    if [ $? != 0 ]; then
      echo "${red}$local_branch (no branch)"
    else
      echo "${green}$local_branch"
    fi

  else
    echo "${green}$local_branch${reset}...${red}$upstream_branch"
  fi
}

function get_change() {
  if [[ -n $(git status --porcelain) ]]; then
    echo '${orange}! '
  fi
}

function git_prompt_info() {
  if is_repo; then
    echo "$(get_change)$(get_branch)"
  fi
}
