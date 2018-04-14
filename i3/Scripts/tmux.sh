#!/bin/sh
tmux kill-server
tmux att -t get ||
tmux \
	new \; \
  neww ./tg/bin/telegram-cli \; \
  neww alsamixer\; \
	selectw -t 0\; \
