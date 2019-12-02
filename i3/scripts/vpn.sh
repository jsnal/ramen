#!/bin/sh
clear
name=$(ls /opt/ovpn -1 | echo $(dmenu -i -l 20 -p VPN))
xterm -e "sudo openvpn /opt/ovpn/$name"
