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
  exit 0
}

function getBootupStats() {
  local boot_time=$(uptime -s)
  local boot_services=$(systemctl list-unit-files | grep enabled | wc -l)

  echo -e "Last bootup for $(hostname)\n"

  echo -e "Boot time: $boot_time"
  echo -e "Services started: $boot_services\n"
}

getBootupStats

for i in ${!profiles[@]}; do echo -e "$i -> ${profiles[$i]}"; done
echo
read -p "Select bootup profile: " bootProfile

${profiles[$bootProfile]}
i3-msg [class="tmux"] move scratchpad
