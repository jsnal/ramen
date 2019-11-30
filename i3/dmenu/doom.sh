#!/bin/bash

prompt=$(echo "Pick WAD:")
back=$(echo \#000000)
fore=$(echo \#cc0000)
selback=$(echo \#333)
selfore=$(echo \#ffb52a)
DOOM_DIR="$HOME/.doom"
res=$(find $DOOM_DIR -type f | sed -e 's,'"$DOOM_DIR"',,' -e 's,/,,g' | dmenu -b -p "$prompt" -nb $back -nf $fore -sb $selback -sf $selfore)
engine="prboom-plus"

if [ ! -d $DOOM_DIR ]; then
  mkdir -p $DOOM_DIR
  wget -O $DOOM_DIR/freedoom.zip https://github.com/freedoom/freedoom/releases/download/v0.11.3/freedoom-0.11.3.zip
  unzip -j $DOOM_DIR/freedoom.zip -d $DOOM_DIR && rm $DOOM_DIR/*.txt $DOOM_DIR/*.html $DOOM_DIR/*.zip
fi
if [ -z $res ]; then exit 1; fi

notify-send "Now Playing: "$res
$engine $DOOM_DIR/$res
