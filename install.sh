#!/usr/bin/env bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGES=("python3-pip" "zsh" "curl" "vim" "jq" "git")
PROFILEINST=false
VERINST=false
CIINST=false

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    -pfl|--profile)
      PROFILEINST=true
      PROFILE_SELECT=$2
      shift
      ;;
    -v|--verify-install)
      VERINST=true
      shift
      ;;
    -ci|--count-integration)
      CIINST=true
      shift
      ;;
    -i|--ignore)
      ignore_list=$(echo $2 | sed 's/,/ /g')
      shift
      shift
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

set -- "${POSITIONAL[@]}"

function verify-install() {
  echo "Verifying Install"
  file=(
  $DOTFILES_DIR/vim/vimrc \
  $DOTFILES_DIR/zsh/zshrc \
  $DOTFILES_DIR/X/xbindkeysrc \
  $DOTFILES_DIR/X/xmodmap \
  $DOTFILES_DIR/X/xinitrc \
  $DOTFILES_DIR/tmux.conf \
  $DOTFILES_DIR/.gitconfig \
  $DOTFILES_DIR/i3/config \
  )
  for i in ${file[@]}; do
    if [ -f "$i" ]; then
      echo "-> $i Found"
    else
      echo "$i not found."
      echo "Install not verified"
      exit 1
    fi
  done
  exit 0
}

if [[ $WEBINST = true ]]; then web-install; fi
if [[ $VERINST = true ]]; then verify-install; fi

echo "Checking Installed Packages"
for i in "${PACKAGES[@]}"; do
  if echo $ignore_list | grep -q $i; then
    echo '' &>/dev/null
  else
    dpkg -s $i &> /dev/null
  fi
  if [ $? -eq 0 ]; then
    if echo $ignore_list | grep -q $i; then
      echo "-> $i Ignored"
    else
      echo "-> $i Installed"
    fi
  else
    echo -e "Install Failed\nPlease Install ${PACKAGES[@]}"
    read -p "Do you wish to install this program? " response
    case $response in
      [Yy]* ) sudo apt-get install ${PACKAGES[@]}; echo -e "\nPackages installed."; break;;
      [Nn]* ) exit 1;;
      * ) echo "Please answer yes or no.";;
    esac
  fi
done

echo "Cloning i3wm Repository"
if [ -d $HOME/i3wm ]; then
  echo "-> Found $HOME/i3wm"
else
  git clone --recursive --quiet https://github.com/JasonLong24/i3wm $HOME/i3wm &>/dev/null
fi

echo "Installing dotdrop"
sudo pip3 install -q -r $HOME/i3wm/dotdrop/requirements.txt
echo "Dotdrop Installed"
if [[ $PROFILEINST = true ]]; then
  $HOME/i3wm/dotdrop.sh install --profile $($HOME/i3wm/dotdrop.sh list | sed -e '/^$/d' -e 1d | awk 'NR==profile {print $2}' profile="${PROFILE_SELECT}")
else
  $HOME/i3wm/dotdrop.sh list | sed -e '/^$/d' -e 1d | awk '{print $2}' | nl
  read -p "What profile would you like to install? " profile
  $HOME/i3wm/dotdrop.sh install --profile $($HOME/i3wm/dotdrop.sh list | sed -e '/^$/d' -e 1d | awk 'NR==profile {print $2}' profile="${profile}")
fi

echo "Install Complete! Restart your terminal."
