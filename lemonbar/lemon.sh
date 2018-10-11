#!/usr/bin/env bash

workspace() {
  current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
  windows=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
  windows[$(expr $current - 1)]="["%{F\#00ff00}$current%{F\#fff}"]"
  echo ${windows[@]}
}

clock() {
  date +%I:%M
}

battery() {
  bat=$(cat /sys/class/power_supply/BAT0/capacity)
  if [[ bat -ge 70 ]]; then
    echo %{F\#00ff00}$bat%{F\#fff}
  elif [[ bat -le 69 && $bat -ge 26 ]]; then
    echo %{F\#ffff00}$bat%{F\#fff}
  else
    echo %{F\#cc0000}$bat%{F\#fff}
  fi
}

ssid() {
  echo %{F\#00ff00}$(iwgetid -r)%{F\#fff}
}

address() {
  ip addr | ag "inet " | tr "/" " " | awk '{if (NR!=1) {print $2}}'
}

brightness() {
  xbacklight | grep -o '^[0-9]*\.[0-9]'
}

volume() {
  amixer -M | grep Mono | awk 'NR==2 {print $4}' | sed 's/[^0-9]*//g'
}

while true; do
  BAR_LEFT="%{l}$(workspace)"
  BAR_RIGHT="%{r} B: $(brightness) | V: $(volume) | $(clock) | $(ssid) | $(address) | $(battery)%"
  echo $BAR_LEFT $BAR_RIGHT
  sleep .5 
done
