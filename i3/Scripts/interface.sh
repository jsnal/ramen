#!/bin/bash

if [ $(which grep) ]; then
  interfaces=$(ip addr| grep ": " | awk '{if (NR!=1) {print $2}}' | sed -e "s/\://g")
    echo $interfaces
fi 
