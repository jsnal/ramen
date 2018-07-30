#!/usr/bin/env bash

prompt=$(echo Run:)
back=$(echo \#000000)
fore=$(echo \#cc0000)
selback=$(echo \#333)
selfore=$(echo \#ffb52a)
dmenu_run -b -p $prompt -nb $back -nf $fore -sb $selback -sf $selfore
