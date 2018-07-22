#!/usr/bin/env bash

availDirs=$(find . -maxdepth 1 -type d | grep -v build | tail -n +2 | cut -d '/' -f 2)
dirCount=$(echo */ | tr -d '/' | sed -e 's/build //g' | wc -w)
function listDirs() {
  echo "$availDirs" | nl -w2
  read -p "Compile?(0=All) " dirPick
}

function onDirPick() {
  rm -rf build/*
  if [[ $dirPick = "0" ]]; then
    for (( i=1;i<=$dirCount;i++ )); do
      mkdir -v -p build/$(echo */ | tr -d '/' | sed -e 's/build //g' | awk '{print $number}' number=$i) 
    done
  elif [[ $dirPick =~ ^[1-9]+$ ]]; then
    mkdir -v -p build/$(echo "$availDirs" | awk NR==$dirPick) 
  fi
}

if [[ $1 = "" ]]; then
  if [[ -f .drivecompile ]] && [[ -d build ]]; then
    listDirs
    onDirPick
  else
    echo This Directory is not initialized.
  fi
elif [[ $1 = "init" ]]; then
  if [[ -f .drivecompile ]] && [[ -d build ]]; then
    echo This Directory is already initialized.
  else
    touch .drivecompile
    mkdir build
  fi
fi
