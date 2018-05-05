tmux kill-server
tmux att -t get ||
tmux -2 \
	new \; \
	neww ~/tg/bin/telegram-cli -W -N\; \
  neww ncmpcpp\; \
	neww alsamixer\; \
	selectw -t 0\; \
