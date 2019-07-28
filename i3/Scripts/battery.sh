#!/bin/bash

BAT_PERCENT=$(cat /sys/class/power_supply/BAT0/capacity)

[ -z $BAT_PERCENT ] && notify-send "No Battery Found" && exit 1

notify-send "Battery at $BAT_PERCENT%" && exit 0
