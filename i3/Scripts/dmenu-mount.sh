#!/usr/bin/env bash
# Be sure askpass is set in your sudo.conf, i.e.
# echo "Path askpass /usr/bin/ssh-askpass" >> /etc/sudo.conf
pgrep -x dmenu && exit

getmount() {
  [ -z "$chosen" ] && exit 1
  mp="$(echo "$pmp" | dmenu -i -p "Type in mount point.")"
  [ "$mp" = "" ] && exit 1
  if [ ! -d "$mp" ]; then
    mkdiryn=$(printf "No\\nYes" | dmenu -i -p "$mp does not exist. Create it?")
    [ "$mkdiryn" = "Yes" ] && (mkdir -p "$mp" || sudo -A mkdir -p "$mp")
  fi
}

mountusb() {
  chosen="$(echo "$usbdrives" | dmenu -i -p "Mount which drive?" | awk '{print $1}')"
  sudo -A mount "$chosen" && exit 0
  pmp=$(find /mnt /media -type d -maxdepth 5)
  getmount
  sudo -A mount "$chosen" "$mp" && pgrep -x dunst && notify-send "$chosen mounted to $mp."
}

mountandroid() {
  chosen=$(echo "$anddrives" | dmenu -i -p "Which Android device?" | cut -d : -f 1)
  getmount "$HOME -type d -maxdepth 3"
  simple-mtpfs --device "$chosen" "$mp"
  echo simple-mtpfs --device "$chosen" "$mp"
}

asktype() {
  case $(printf "USB\\nAndroid" | dmenu -i -p "Mount a USB drive or Android device?") in
    USB) mountusb ;;
    Android) mountandroid ;;
  esac
}

anddrives=$(simple-mtpfs -l 2>/dev/null)
usbdrives="$(lsblk -rpo "name,type,size,mountpoint" | awk '$2=="part"&&$4==""{printf "%s (%s)\n",$1,$3}')"

if [ -z "$usbdrives" ]; then
  [ -z "$anddrives" ] && echo "No USB drive or Android device detected" && notify-send "No USB drive or Android device detected" && exit
  echo "Android device detected."
  mountandroid
else
  echo "USB drive(s) detected."
  if [ -z "$anddrives" ]; then
    echo "USB drive detected."
    mountusb
  else
    echo "Mountable USB drive(s) and Android device(s) detected."
    asktype
  fi
fi

