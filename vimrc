execute pathogen#infect()

"set leader let mapleader = ","
filetype plugin indent on

au BufEnter,BufNew *.php :set filetype=html
au BufEnter,BufNew *.php :set syntax=php

command! Wq :wq
command! W :w

" Setting random things
set background=dark
set path+=**
set wildmenu  
let g:EasyMotion_leader_key = '<Leader>'

"Line things
set number
syntax on
colorscheme one-dark 

filetype plugin indent on
"autocmd VimEnter * NERDTree

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

" Remapping binds
map <F2> :NERDTreeToggle<CR>
noremap <TAB>   <C-W>w
noremap <CAPS> <ESC>
"map wq <ESC>dw:wq<CR>
"map Wq <ESC>dw:wq<CR>

" Turn off swap files
set noswapfile
set nobackup
set nowb
