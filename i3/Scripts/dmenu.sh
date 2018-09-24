#!/usr/bin/env bash

prompt=$(echo Run:)
back=$(echo \#000000)
fore=$(echo \#cc0000)
selback=$(echo \#000000)
selfore=$(echo \#ffb52a)
font=$(echo \'terminus:pixelsize=13:antialias=true\')
lines=$(echo 15)
dmenu_run -b -p $prompt -nb $back -nf $fore -sb $selback -sf $selfore -l $lines -fn $font
