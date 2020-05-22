#!/usr/bin/env zsh

# Global Options
typeset -g GIT_LEFT_BRACKET='['
typeset -g GIT_RIGHT_BRACKET=']'

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

  if [ -f $(git rev-parse --git-dir)/MERGE_HEAD ]; then
    local ongoing_merge=" ${_ramen[MAGENTA]}(merge)"
  fi

  # Check if you're attached to a branch
  git symbolic-ref HEAD &>/dev/null
  if [ $? != 0 ]; then
    echo "${_ramen[RED]}$(git name-rev --name-only --no-undefined --always HEAD)${_ramen[WHITE]}"
  else
    echo "${_ramen[LIGHT_GRAY]}$local_branch$ongoing_merge${_ramen[WHITE]}"
  fi
}

# Get any changes within the repository in real time.
# Symbols:
#   ! - Changes
#   ? - Untracked Files
#   # - Deleted Files
#   $ - Stashed Changes
function get_change() {
  local symbols=""

  # check for any changes
  [[ -n $(git status --porcelain 2>/dev/null) ]] && local symbols="${symbols}!"

  # check for untracked files
  [[ -n $(git ls-files --other --directory --exclude-standard 2>/dev/null) ]] && local symbols="?${symbols}"

  # check for deleted files
  [[ -n $(git ls-files --deleted --directory --exclude-standard 2>/dev/null) ]] && local symbols="${symbols}#"

  # check for stashed changes
  command git rev-parse --verify refs/stash &> /dev/null && local symbols="${symbols}$"

  # don't add the extra space if the working tree is clean
  [[ -z $symbols ]] && echo "" && return

  echo " ${_ramen[ORANGE]}$symbols${_ramen[WHITE]}"
}

function git_prompt_info() {
  if is_repo; then
    printf "$GIT_LEFT_BRACKET%s%s$GIT_RIGHT_BRACKET" "$(get_branch)" "$(get_change)"
  fi
}
