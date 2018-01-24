#!/bin/bash

if [ $(which grep) ]; then
  ips=$(ip addr | ag "inet " | tr "/" " " | awk '{if (NR!=1) {print $9,$2}}' | sed -e $':a' -e 'N' -e '$!ba' -e 's/\n/\ | /g')
  echo $ips
fi 
