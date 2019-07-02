#!/bin/bash

compileDirectories=$(find . -maxdepth 1 -type d | grep -v build | sed -e 1d -e 's/^.\///g')
dirCount=$(echo "$compileDirectories" | wc -l)
