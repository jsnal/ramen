#!/bin/bash

d=$(date +%Y-%m-%d-%T-screengrab.png)
echo "$d"
scrot ~/Screenshots/%Y-%m-%d-%T-screengrab.png
display ~/Screenshots/"$d"
