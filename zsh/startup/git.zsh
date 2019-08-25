#!/usr/bin/env zsh

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
      echo "${_i3wm[RED]}$(git name-rev --name-only --no-undefined --always HEAD) (no branch)"
    else
      echo "${_i3wm[GREEN]}$local_branch"
    fi

  else
    echo "${_i3wm[GREEN]}$local_branch${_i3wm[WHITE]} > ${_i3wm[RED]}$upstream_branch"
  fi
}

# Get any changes within the repository in real time.
# Symbols:
#   ! - Changes
#   ? - Untracked Files
#   # - Deleted Files
function get_change() {
  local symbols=""

  # check for any changes
  [[ -n $(git status --porcelain) ]] && local symbols="${symbols}!"

  # check for untracked files
  [[ -n $(git ls-files --other --directory --exclude-standard) ]] && local symbols="?${symbols}"

  # check for deleted files
  [[ -n $(git ls-files --deleted --directory --exclude-standard) ]] && local symbols="${symbols}#"

  echo "${_i3wm[ORANGE]}$symbols "
}

function git_prompt_info() {
  if is_repo; then
    echo "$(get_change)$(get_branch)"
  fi
}
