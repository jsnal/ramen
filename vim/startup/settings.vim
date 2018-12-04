set background=dark
colorscheme badwolf
syntax on

" General
set nocompatible 
set laststatus=2
set backspace=indent,eol,start
set path+=**
set wildmenu
set shortmess=a
set cmdheight=2
set showmode
set splitbelow splitright

" Numbering and Indent
set number
set relativenumber
set wrap
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set foldcolumn=2
set hlsearch
set linebreak

" File Settings
set fileformat=unix
set fileformats=unix
set fileencoding=utf-8
set fileencodings=utf-8
set encoding=utf-8
set ambiwidth=double
set showcmd
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp

" Hilight Cursor Words
let g:HiCursorWords_linkStyle='Underlined'
let g:HiCursorWords_delay = 100

" Presistent Undo
if has ('persistent_undo')
  set undodir=$HOME/.vim_undo
  set undolevels=5000
  set undofile
endif

" Netrw
let g:proj_window_width = 34
let g:proj_window_increment = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
