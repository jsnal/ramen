#!/bin/bash

function a() {
  todolist a "$@" "$last"
  commit=$(echo -e $@ | tr -d '[:space:]')
  last=$(echo $@ | awk '{print $NF}')
  cd ~/tll && git add . && git commit -m "$commit" -q && git push -q origin master 
  cd $OLDPWD
}

function c() {
  todolist c "$@"
  todolist ac && todolist gc
  commit=$(echo -e $@ | tr -d '[:space:]')
  cd ~/tll && git add . && git commit -m "$commit" -q && git push -q origin master 
  cd $OLDPWD
}

function l() {
  cd ~/tll && git pull -q origin master && cd $OLDPWD 
  todolist l by project && printf "\n\n" && cal 
}

"$@"
