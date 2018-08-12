#!/usr/bin/env bash
# Toggle Computer Status Polybar

stat=$(ps aux | grep -w "[p]olybar status" | awk '{print $2}')
if [[ -z $stat ]]; then
  polybar status &
else
  kill $stat
fi
