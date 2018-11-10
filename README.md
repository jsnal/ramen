# i3wm Config [![Build Status](http://jasonlong24.crabdance.com:8080/buildStatus/icon?job=i3wm)](http://192.168.86.107:8080/job/i3wm/)
 My i3wm config, scripts and setup.

 vim [Snippets](https://github.com/JasonLong24/snippets)
### Setup
- Clone this repo into your home directory
- Run the installer.sh

or

```
bash <(wget -qO- https://raw.githubusercontent.com/JasonLong24/i3wm/master/install.sh) --web
```
##### After Install Config
The after install config is located in the root directory. To use it just write a command you want to run after the install is complete.
__*NOTE: Please delete all lines execpt for #!bin/bash so it doesn't run when it shouldn't*__

#### Or install by hand
- Install dependencies
- Install fonts for polybar in ~/usr/share/fonts
- Clone [snippets](https://github.com/JasonLong24/snippets) into ~/.vim
- Clone this github into ~/.config/

### Tools
- i3Blocks
    - Replacement for i3Status
    - [Install Package](https://www.archlinux.org/packages/community/i686/i3blocks/)
- i3Gaps
    - Enables customization of the gaps in between windows
    - [Install Package](https://aur.archlinux.org/packages/i3-gaps-git/)
- Rofi
    - Replacement for dmenu
    - Used for different types of menus
    - See all the menus in ~/.config/i3/Rofi/
    - [Install Package](https://www.archlinux.org/packages/community/x86_64/rofi/)
- Zsh
    - [Install package](https://www.archlinux.org/packages/extra/x86_64/zsh/)
- Scrot
    - Used for screenshot script
    - [Install package](https://www.archlinux.org/packages/community/i686/scrot/)
- Gyazo
    - Screenshot tool for certain parts of the screen
    - [Install Package](https://aur.archlinux.org/packages/gyazo/)
- Polybar
    - Replacement for i3Blocks but I still use some of the i3Block scripts
    - [Install Package](https://github.com/jaagr/polybar)
    
### Fonts
- Unifont
    - [Install Package](https://www.archlinux.org/packages/extra/any/bdf-unifont/)
