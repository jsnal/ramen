#!/bin/bash

clear
spinner=( Ooooo oOooo ooOoo oooOo ooooO)

spin(){
  while [ 1 ]
  do
    for i in ${spinner[@]};
    do
      echo -ne "\r$i";
      sleep 0.2;
    done;
  done
}

spin2() {
    i=1
    sp="/-\|"
    echo -n ' '
    for number in 1 2 3 4 5
    do
      printf "\b${sp:i++%${#sp}:1}"
    done
  }

spin
