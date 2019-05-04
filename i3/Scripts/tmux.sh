tmux kill-server
tmux att -t get ||
tmux -2 \
	new \; \
	neww -n 'volume' alsamixer\; \
	selectw -t 0\; \
