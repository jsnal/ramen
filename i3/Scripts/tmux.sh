tmux kill-server
tmux att -t get ||
tmux -2 \
	new \; \
	neww -n 'Telegram' ~/tg/bin/telegram-cli -W -N\; \
  neww ncmpcpp\; \
  neww -n 'TODO' vim ~/i3wm/TODO.txt +":hi clear SpellBad | hi SpellBad cterm=underline"\; \
	neww alsamixer\; \
	selectw -t 0\; \
