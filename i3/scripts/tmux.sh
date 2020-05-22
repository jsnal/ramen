#!/bin/bash

set -e

SESSION="global"

if tmux has-session -t=$SESSION 2> /dev/null; then
  tmux attach -t $SESSION
  exit 0
fi

tmux new-session -d -s $SESSION -n shell -x $(tput cols) -y $(tput lines)

tmux new-window -t $SESSION -n volume 'alsamixer'
tmux new-window -t $SESSION -n profile 'bash ~/ramen/i3/scripts/window-selector.sh'

tmux attach -t $SESSION:profile
