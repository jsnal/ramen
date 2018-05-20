#!/bin/bash

DOTGIT=".git/"
PWD=$(pwd)

function colors() {
  printf '\e[48;5;%dm ' {0..255}; printf '\e[0m \n']
}
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

function is_clean() {
  if [ -z "$(git status --porcelain)" ]; then
    return 0
  else
    return 1
  fi
}

function is_blacklist() {
  for i in "${BLACKLIST[@]}"; do
    if [[ $i = $PWD  ]]; then
      return 1 
    else
      return 0 
    fi
  done
}

function branch() {
  if [ $BRANCH = true ]; then
    BRANCH="$(git symbolic-ref --short HEAD)"
    if is_clean; then
      echo "${COLOR_BRANCH_CLEAN}$BRANCH${reset}"
    else
      echo "${COLOR_BRANCH_DIRTY}$BRANCH${reset}"
    fi

  else echo '' 
  fi
}

function hash() {
  if [ $HASH = true ]; then
    HASH="$(git rev-parse --short HEAD)"
    if [ $STATUS = false ]; then
      echo "(${COLOR_HASH}$HASH${reset})"
    else
      echo "(${COLOR_HASH}$HASH${reset})$SEPERATOR"
    fi
  else echo ''
  fi
}

function status() {
  if [ $STATUS = true ]; then
    ADD=$(git status --porcelain | grep -o "A" | head -1 && git status --porcelain | grep -oE "A" | wc -l)
    MOD=$(git status --porcelain | grep -o "M" | head -1 && git status --porcelain | grep -oE "M" | wc -l)
    DEL=$(git status --porcelain | grep -o "D" | head -1 && git status --porcelain | grep -oE "D" | wc -l)
    REN=$(git status --porcelain | grep -o "R" | head -1 && git status --porcelain | grep -oE "R" | wc -l)
    COP=$(git status --porcelain | grep -o "C" | head -1 && git status --porcelain | grep -oE "C" | wc -l)
    UNT=$(git status --porcelain | grep -o "?" | head -1 && git status --porcelain | grep -oE "\?\?" | wc -l)

    echo ${COLOR_ADD}$ADD ${COLOR_MOD}$MOD ${COLOR_DEL}$DEL ${COLOR_REN}$REN ${COLOR_COP}$COP ${COLOR_UNT}$UNT${reset}| tr -d '\n' | tr '0' ' ' | tr -d ' ' 

  else echo ''
  fi
}

function status_simp() {
  if [ $STATUS_SIMP = true ]; then
    MOD=$(git status --porcelain | grep -oE "M" | wc -l)
    DEL=$(git status --porcelain | grep -oE "D" | wc -l)
    
    if [[ $DEL = "0"  ]] && [[ $MOD = "0" ]]; then
      echo '' 
    else
      echo ${COLOR_ADD}$MOD+ ${reset}${COLOR_DEL}$DEL-${reset} | tr -d '\n' | tr -d ' '
    fi

  else echo ''
  fi
}

function behind_master() {
  if [ $MASTER = true ]; then
    BEHIND=$(git rev-list --left-only --count master...HEAD 2>/dev/null)
    if [[ $BEHIND = "0" ]]; then echo ''
    else
      echo ${COLOR_BEHIND}$BEHIND↓
    fi
  fi
}

function ahead_master() {
  if [ $MASTER = true ]; then
    AHEAD=$(git rev-list --right-only --count master...HEAD 2>/dev/null)
    if [[ $AHEAD = "0" ]]; then echo ''
    else
      echo ${COLOR_AHEAD}$AHEAD↑
    fi
  fi
}

function git_info() {
	if is_repo && is_blacklist; then
    
    echo $SEPERATOR$(branch)$(hash)$(status)$(status_simp) $(behind_master)$(ahead_master)
	fi
}

# Simple Git Prompt

function branch_simp() {
    BRANCH="$(git symbolic-ref --short HEAD)"
    if is_clean; then
      echo "${COLOR_BRANCH_CLEAN}$BRANCH${reset}"
    else
      echo "${COLOR_BRANCH_DIRTY}$BRANCH${reset}*"
    fi
}

function git_simplified_info() {
  if is_repo && is_blacklist && [ $SIMPLIFIED = true ]; then
    HASH=false
    STATUS=false
    STATUS_SIMP=false
    BRANCH=false
    MASTER=false
    echo $SEPERATOR$(branch_simp)
  fi
}

SEPERATOR=""
BLACKLIST=( "" )
COLOR_BRANCH_CLEAN=${green}
COLOR_BRANCH_DIRTY=${purple}
COLOR_BEHIND=${red}
COLOR_AHEAD=${green}
COLOR_HASH=${blue}
COLOR_ADD=${green}
COLOR_MOD=${green}
COLOR_DEL=${red}
COLOR_REN=${cyan}
COLOR_COP=${cyan}
COLOR_UNT=${bldblue}
HASH=true
STATUS=true
STATUS_SIMP=false
BRANCH=true
MASTER=true
SIMPLIFIED=false

"$@"
