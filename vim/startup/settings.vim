" Setup Colorscheme
set background=dark
syntax on
if has('gui_running')
  silent! colorscheme default
else
  silent! colorscheme jellybeans
  hi Normal  ctermbg=NONE
  hi LineNr  ctermbg=NONE
  hi nonText ctermbg=NONE
endif

" General
set nocompatible
set laststatus=2
set backspace=indent,eol,start
set path+=**
set wildmenu
set wildmode=longest:full,full
set shortmess=a
set cmdheight=2
set showmode
set splitbelow splitright
set ignorecase smartcase
set hidden
set updatetime=200

" Numbering and Indent
set number
set relativenumber
set wrap
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set foldcolumn=0
set hlsearch
set incsearch
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
set autochdir
set nobackup
set nowritebackup

" Hilight Cursor Words
let g:HiCursorWords_linkStyle='Underlined'
let g:HiCursorWords_delay = 100

" Presistent Undo
if has ('persistent_undo')
  set undodir=$HOME/.vim_undo
  set undolevels=5000
  set undofile
endif

let g:fzf_nvim_statusline = 0
let g:fzf_layout = { 'right': '~20%' }
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
