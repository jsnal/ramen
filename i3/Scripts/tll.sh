#!/bin/bash
# In repository set:
# git remote add origin "10.52.2.2:8080/JasonLong24/tll"
# git remote add outside "jasonlong24.crabdance.com:8080/JasonLong24/tll"
# Be sure to symlink .todos.json into home dir

ip=$(ip addr | ag "inet " | tr "/" " " | awk '{if (NR!=1) {print $2}}')
if [[ $ip = 10.52.2.* ]]; then
  remote=origin 
else
  remote=outside
fi
echo $remote
function a() {
  todolist a "$@" "$last"
  commit=$(echo -e $@ | tr -d '[:space:]')
  last=$(echo $@ | awk '{print $NF}')
  cd ~/tll && git add . && git commit -m "$commit" -q && git push -q $remote master 
  cd $OLDPWD
}

function c() {
  todolist c "$@"
  todolist ac && todolist gc
  commit=$(echo -e $@ | tr -d '[:space:]')
  cd ~/tll && git add . && git commit -m "$commit" -q && git push -q $remote master 
  cd $OLDPWD
}

function l() {
  cd ~/tll && git pull -q origin master && cd $OLDPWD 
  todolist l by project && printf "\n\n" && cal 
}

"$@"
