#!/usr/bin/env bash
#
# Depends on i3 and jq for workspace data.

workspace() {
  current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d"\"" -f2)
  windows=("web" "2" "3" "4" "5" "6" "7" "8" "9" "10")
  windows[$(expr $current - 1)]="["%{F\#00ff00}$current%{F\#fff}"]"
  echo ${windows[@]}
}

clock() {
  date +%I:%M
}

c_date() {
  date +%D | sed 's/\//-/g'
}

charging() {
  if ! cat /sys/class/power_supply/BAT0/status | grep "Discharging" &>/dev/null; then
    echo "*"
  fi
}

battery() {
  if [ ! -f /sys/class/power_supply/BAT0/capacity ]; then echo ''; else
    local bat=$(cat /sys/class/power_supply/BAT0/capacity)
    if [[ bat -ge 70 ]]; then
      echo '| '%{F\#00ff00}$bat%{F\#fff}'%'$(charging)
    elif [[ bat -le 69 && $bat -ge 26 ]]; then
      echo '| '%{F\#ffff00}$bat%{F\#fff}'%'$(charging)
    else
      echo '| '%{F\#cc0000}$bat%{F\#fff}'%'$(charging)
    fi
  fi
}

ssid() {
  id=$(iwgetid -r)
  if [[ $id == "" ]]; then
    echo %{F\#cc0000}Not Connected%{F\#fff}
  else
    echo %{F\#00ff00}$id%{F\#fff}
  fi
}

address() {
  address=$(ip addr | ag "inet " | tr "/" " " | awk 'NR==2 {print $2}')
  if [[ $address == "" ]]; then
    echo %{F\#cc0000}None%{F\#fff}
  else
    echo %{F\#00ff00}$address%{F\#fff}
  fi
}

brightness() {
  if [ ! -f /sys/class/power_supply/BAT0/capacity ]; then echo ''; else
    echo B: %{F\#00E5E5}$(xbacklight | grep -o '^[0-9]*\.[0-9]')%{F\#fff}
  fi
}

volume() {
  echo %{F\#00E5E5}$(amixer -M | grep Mono | awk 'NR==2 {print $4}' | sed 's/[^0-9]*//g')%{F\#fff}
}

song() {
  current=$($HOME/i3wm/zsh/scripts/spotify-info.sh title)
  if [[ $current = "" ]]; then
    echo ""
  else
    echo $current \|
  fi
}

ssh-info() {
  sessions="$(lsof -Pi | grep "ssh")"
  if [ ! -z "$sessions" ]; then
    count=$(echo "$sessions" | wc -l)
    echo "SSH: $count |"
  else
    echo ""
  fi
}

win-info() {
  echo " []="$(cat /proc/$(xdotool getwindowpid $(xdotool getwindowfocus))/comm)
}

while true; do
  BAR_LEFT="%{l}$(workspace) $(win-info)"
  BAR_RIGHT="%{r} $(ssh-info) $(brightness) | V: $(volume) | $(clock) | $(c_date) | $(ssid) | $(address) $(battery)"
  echo $BAR_LEFT $BAR_RIGHT
  sleep 15
done
