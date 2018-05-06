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

If you want to change any options add these to your `.bashrc` or `.zshrc`
```
SEPERATOR=":"
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
```

## Features
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

