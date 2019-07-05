#!/bin/bash

compileDirectories=$(find . -maxdepth 1 -type d | grep -v -e "build" -e "ignore" | sed -e 1d -e 's/^.\///g')
dirCount=$(echo "$compileDirectories" | wc -l)
MASTER_DOC="false"
f_verbose=''

function isProjectInit() {
  if [ -f .mdcompile ] && [ -d build ]; then
    return 1
  else
    return 0
  fi
}

function projectInit() {
  if ! isProjectInit; then
    echo 'This project is already initialized'
  else
    touch .mdcompile && mkdir -p build
  fi
}

function compileAll() {
  echo 'Compiling all detected directories...'
  for (( i=1;i<=$dirCount;i++ )); do
    local currentDir=$(echo "$compileDirectories" | awk NR==$i)
    local fileCount=$(ls -1q $(echo "$compileDirectories" | awk NR==$i)/*.md | wc -l)
    local files=$(ls -1q $(echo "$compileDirectories" | awk NR==$i)/*.md)
    for (( j=1;j<=$fileCount;j++ )); do
      mkdir -p build/$(echo "$files" | awk NR==$j | cut -d'/' -f1)
      pandoc $f_verbose $(echo "$files" | awk NR==$j) --output build/$(echo "$files" | awk NR==$j | cut -f 1 -d '.').pdf
    done
  done
}

function compileSingle() {
  echo 'Compiling' $1
  local fileCount=$(ls -1q $(echo "$compileDirectories" | grep $1)/*.md | wc -l)
  local files=$(ls -1q $(echo "$compileDirectories" | grep $1)/*.md)
  for (( i=1;i<=$fileCount;i++ )); do
    mkdir -p build/$1
    pandoc $f_verbose $(echo "$files" | awk NR==$i) --output build/$(echo "$files" | awk NR==$i | cut -f 1 -d '.').pdf
  done
}

function compileMasterDoc() {
  echo 'Compiling master doc...'
  pdfunite $(find build -maxdepth 2 -type f | sort) build/master.pdf
}

function mdcompile() {
  local fzf_return=$({ echo "$compileDirectories" && echo "all"; } | fzf --height 20%)
  [ -z $fzf_return ] && echo "Cancelling compiler..." && exit 1
  case $fzf_return in
    'all')
      compileAll ;;
    *)
      compileSingle $fzf_return ;;
  esac
}

# Check if the project is initialized
if ! echo $@ | grep -x '\-i\|\-\-init' > /dev/null; then
  isProjectInit && echo 'Please initialize this project' && exit 1
fi

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -i|--init)
      projectInit; exit ;;
    -v|--verbose)
      f_verbose="--verbose"; shift ;;
    -c|--clear)
      rm -rf build && mkdir -p build; shift ;;
    -md|--master-doc)
      MASTER_DOC="true"; shift ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done
set -- "${POSITIONAL[@]}"

mdcompile
[ $MASTER_DOC = "true" ] && compileMasterDoc && exit 0