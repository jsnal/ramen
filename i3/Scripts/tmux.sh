tmux kill-server
tmux att -t get ||
tmux -2 \
	new \; \
	neww -n 'volume' alsamixer\; \
  neww -n 'profile' bash ~/i3wm/i3/Scripts/window-selector.sh\; \
	selectw -t 2\; \
