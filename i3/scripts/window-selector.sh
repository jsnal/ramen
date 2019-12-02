#!/bin/bash

profiles=("home" "out" "minimal")
function start() { i3-msg exec $1; }
function home() {
  start firefox
  start spotify
}

function out() {
  start firefox
}

function minimal() {
  start st
}

echo
for i in ${!profiles[@]}; do echo -e "$i\t${profiles[$i]}"; done
echo
read -p "Select bootup profile. " bootProfile

${profiles[$bootProfile]}
i3-msg [class="tmux"] move scratchpad
