#!/bin/bash

DOTGIT=".git/"

function colors() {
  bld=$(tput bold)
  reset=$(tput sgr0)

  bldred=${bld}$(tput setaf 1) 
  bldgreen=${bld}$(tput setaf 2)
  bldyellow=${bld}$(tput setaf 3)
  bldblue=${bld}$(tput setaf 4)
  bldpurple=${bld}$(tput setaf 5)
  bldcyan=${bld}$(tput setaf 6) 
  bldwhite=${bld}$(tput setaf 7)

  red=$(tput setaf 1) 
  green=$(tput setaf 2)
  yellow=$(tput setaf 3)
  blue=$(tput setaf 4)
  purple=$(tput setaf 5)
  cyan=$(tput setaf 6) 
  white=$(tput setaf 7)
}

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

function branch() {
  BRANCH="$(git symbolic-ref --short HEAD)"
  echo "${purple}$BRANCH${reset}"
}

function hash() {
  HASH="$(git rev-parse --short HEAD)"
	echo "${blue}$HASH"
}

function status() {
	ADD=$(git status --porcelain | grep -o "A" | head -1 && git status --porcelain | grep -oE "A" | wc -l)
	MOD=$(git status --porcelain | grep -o "M" | head -1 && git status --porcelain | grep -oE "M" | wc -l)
	DEL=$(git status --porcelain | grep -o "D" | head -1 && git status --porcelain | grep -oE "D" | wc -l)
	REN=$(git status --porcelain | grep -o "R" | head -1 && git status --porcelain | grep -oE "R" | wc -l)
	COP=$(git status --porcelain | grep -o "C" | head -1 && git status --porcelain | grep -oE "C" | wc -l)
  UNT=$(git status --porcelain | grep -o "?" | head -1 && git status --porcelain | grep -oE "\?\?" | wc -l)

	echo ${green}$ADD ${red}$MOD $DEL $REN $COP $UNT| tr -d '\n' | tr '0' ' ' 
}

function git_info() {
	if is_repo; then
		echo $(branch):$(status)
	fi
}

colors

"$@"
