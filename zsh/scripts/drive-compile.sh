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

function compile() {
  if [[ $dirPick = "0" ]]; then
    for (( i=1;i<=$dirCount;i++ )); do
      currentDir=$(echo "$availDirs" | awk NR==$i)
      fileCount=$(ls -1q $(echo "$availDirs" | awk NR==$i)/*.md | wc -l)
      files=$(ls -1q $(echo "$availDirs" | awk NR==$i)/*.md)
      for (( j=1;j<=$fileCount;j++ )); do
        pandoc --verbose $(echo "$files" | awk NR==$j) --output build/$(echo "$files" | awk NR==$j | cut -f 1 -d '.').pdf
      done
    done
  elif [[ $dirPick =~ ^[1-9]+$ ]]; then
    fileCount=$(ls -1q $(echo "$availDirs" | awk NR==$dirPick)/*.md | wc -l)
    files=$(ls -1q $(echo "$availDirs" | awk NR==$dirPick)/*.md)
    for (( i=1;i<=$fileCount;i++ )); do
      pandoc --verbose $(echo "$files" | awk NR==$i) --output build/$(echo "$files" | awk NR==$i | cut -f 1 -d '.').pdf
    done
  fi
}

function start() {
  if [[ -f .drivecompile ]] && [[ -d build ]]; then
    if [[ $all = 0 ]]; then
      listDirs
    fi 
    onDirPick
    compile
    echo -e "\nBuild finished"
  else
    echo This Directory is not initialized.
  fi
}

if [[ $1 = "" ]]; then
  all=0
  start
elif [[ $1 = "--all" ]] || [[ $1 = "-a" ]]; then
  dirPick=0
  start
elif [[ $1 = "init" ]]; then
  if [[ -f .drivecompile ]] && [[ -d build ]]; then
    echo This Directory is already initialized.
  else
    touch .drivecompile
    mkdir build
  fi
fi
