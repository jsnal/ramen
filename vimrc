syntax on
set shiftwidth=2 softtabstop=2 expandtab

"set leader let mapleader = ","
let g:EasyMotion_leader_key = '<Leader>' 
"I don't like auto indent
"set noautoindent
"filetype indent on
filetype plugin indent on
au BufEnter,BufNew *.php :set filetype=html
au BufEnter,BufNew *.php :set syntax=php

"ab wq <ESC>dw:wq<CR>
"ab Wq <ESC>dw:wq<CR>
set path+=**
set wildmenu

""set theme to darkbackground
set background=dark

"line numbering
set number

execute pathogen#infect()
syntax on
colorscheme one-dark 
filetype plugin indent on
"autocmd VimEnter * NERDTree
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
map <F2> :NERDTreeToggle<CR>

" Command rempas
command! Wq :wq
command! W :w
command! Q :q
cabbrev fzf FZF 

" Binding remaps
noremap <TAB>q <C-W>w
noremap <TAB>s <C-W>s
noremap <TAB>v <C-W>v

" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#syntastic#enabled=0
let g:ycm_show_diagnostics_ui=0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#whitespace#show_message=0
let g:airline_symbols.maxlinenr = ''

