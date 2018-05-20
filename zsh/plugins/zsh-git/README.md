# Git Prompt

An easy to use git prompt tool.

## Installation

```
source $HOME/i3wm/zsh/plugins/zsh-git/git.sh
```

## Usage

Add to your `.zshrc`
`PROMPT=":$(git_info)"`

Add to your `.bashrc`
`PS1=":$(git_info)"`

If the colors don't work you can run `./git.sh colors` to test the color output. 

If you want to change any options add these to your `.bashrc` or `.zshrc`
```
SEPERATOR=":"
BLACKLIST=( "" )
COLOR_BRANCH_CLEAN=${green}
COLOR_BRANCH_DIRTY=${purple}
COLOR_BEHIND=${red}
COLOR_AHEAD=${green}
COLOR_HASH=${blue}
COLOR_ADD=${green}
COLOR_MOD=${green}
COLOR_DEL=${red}
COLOR_REN=${cyan}
COLOR_COP=${cyan}
COLOR_UNT=${bldblue}
HASH=true
STATUS=true
STATUS_SIMP=true
BRANCH=true
SIMPLIFIED=false
```
> Supports default 7 colors and default bold colors.

## Features
> Simplified Prompt just includes the current branch. It changes the clean and dirty color. Note: Once you enable the simplified prompt in your bashrc/zshrc it will disable everything else.
### Branch
Branch tells you the current branch you are on

By Default
- Green -> Clean Branch
- Purple -> Dirty Branch

### Hash 
Hash tells you the current hash of HEAD

### Status 
Status uses `git status --porcelain` to tell you information about changes

### Status Simp
Status Simp tells you just removed and modified files but does not include untracked files

### Master
Tells you how far you are behind or ahead of master

### Blacklist
You can blacklist directories from using the prompt. Declare the blacklist like an array with the full path to the directory. i.e `BLACKLIST=( "/home/jason/<Dir1>" "/home/jason/<Dir2>" )`

