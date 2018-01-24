"---------------------------------------------------------------------------
" Vim Plug{{{

call plug#begin('~/.vim/plugged')

" Utils
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/mhinz/vim-signify'
Plug 'https://github.com/junegunn/fzf'
Plug 'https://github.com/scrooloose/nerdtree', { 'off': 'NERDTreeToggle' }
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/pboettch/vim-highlight-cursor-words'

" Theming
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/kristijanhusak/vim-hybrid-material'

" Language Specific 
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'https://github.com/Shutnik/jshint2.vim'

call plug#end()
"}}}
"---------------------------------------------------------------------------
" Initializing{{{

syntax on
set t_Co=256
scriptencoding utf-8
let mapleader = ","
let g:EasyMotion_leader_key = '<Leader>' 
"}}}
"---------------------------------------------------------------------------
" set theme to darkbackground{{{

set background=dark
set hlsearch
colorscheme hybrid_reverse 
"let g:hybrid_custom_term_colors = 1
"}}}
"---------------------------------------------------------------------------
" line numbering and indentation{{{

set number
set relativenumber
filetype plugin indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set shiftwidth=2 softtabstop=2 expandtab

"autocmd VimEnter * NERDTree
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
"}}}
"---------------------------------------------------------------------------
" File Settings{{{

set fileformat=unix
set fileformats=unix
set fileencoding=utf-8
set fileencodings=utf-8
set encoding=utf-8
set ambiwidth=double

set backup
set showcmd
"}}}
"---------------------------------------------------------------------------
" Command rempas{{{

command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Wqa :wqa
cabbrev fzf FZF 
"}}}
"---------------------------------------------------------------------------
" Binding remaps{{{

noremap <TAB>q <C-W>w
" noremap <TAB>s <C-W>s
" noremap <TAB>v <C-W>v

" End and beginnging line
noremap H ^
noremap L g_

" Very magic search
nnoremap / /\v
vnoremap / /\v

map <F2> :NERDTreeToggle<CR>
map <F3> :setlocal spell! spelllang=en_us<CR> 
map <F4> :JSHint<CR><CR>
map <F5> :setlocal foldmethod=marker<CR> 
map <C-F> :fzf<CR>

nnoremap <silent> <TAB>v :call fzf#run({
      \   'right': winwidth('.') / 2,
      \   'sink':  'vertical botright split' })<CR>

nnoremap <silent> <TAB>x :call fzf#run({
      \   'down': '40%',
      \   'sink': 'botright split' })<CR>

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>
"}}}
"---------------------------------------------------------------------------
" Buffers{{{

map <Leader>a :bprev<Return>
map <Leader>s :bnext<Return>
map <Leader>d :bd<Return>
map <Leader>f :b

au BufWinLeave * mkview
au BufWinEnter * silent loadview

"" Show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"}}}
"---------------------------------------------------------------------------
" Airline{{{

"let g:airline_theme = "hybrid"

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline#extensions#tabline#enabled = 1
"let g:airline_left_sep=''
"let g:airline_right_sep=''
let g:airline#extensions#syntastic#enabled=0
let g:ycm_show_diagnostics_ui=0
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#whitespace#show_message=0
let g:airline_symbols.maxlinenr = ''
let g:airline#extensions#tabline#fnamemod = ':t'
"}}}
"---------------------------------------------------------------------------
" Settings things{{{

set path+=**
set wildmenu
set nocompatible
set noswapfile
set shortmess=a
set cmdheight=2

" HiCursorWords
let g:HiCursorWords_linkStyle='Underlined'
let g:HiCursorWords_debugEchoHiName = 1
let g:HiCursorWords_delay = 100
let g:vim_markdown_folding_disabled = 1
" let g:indentLine_color_term = 254
let g:indentLine_char = '▏'
"}}}
