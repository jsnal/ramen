#!/bin/bash

compileDirectories=$(find . -maxdepth 1 -type d | grep -v build | sed -e 1d -e 's/^.\///g')
dirCount=$(echo "$compileDirectories" | wc -l)
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
      pandoc $f_verbose $(echo "$files" | awk NR==$j) --output build/$(echo "$files" | awk NR==$j | cut -f 1 -d '.').pdf
    done
  done
}

function mdcompile() {
  local fzf_return=$({ echo "$compileDirectories" && echo "all"; } | fzf)
  case $fzf_return in
    'all')
      compileAll; exit 0 ;;
    *)
      echo 'Please pick a valid option.'; exit 1 ;;
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
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done
set -- "${POSITIONAL[@]}"

mdcompile
