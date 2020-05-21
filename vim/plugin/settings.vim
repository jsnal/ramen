" Setup Colorscheme
set background=dark

if has('syntax')
  syntax on
endif

if has('gui_running')
  silent! colorscheme default
else
  silent! colorscheme serape
  hi Normal  ctermbg=none
  hi LineNr  ctermbg=none
  hi NonText ctermbg=none
endif

" Automatically try to find the filetype
filetype plugin on

" General
set nocompatible
set laststatus=2
set backspace=indent,eol,start
set path+=**
set wildmenu
set wildmode=longest,list,full
set shortmess=c
set cmdheight=2
set showmode
set splitbelow splitright
set ignorecase smartcase
set hidden
set updatetime=200
set noshowmode
set switchbuf=useopen
set belloff=ctrlg
" set formatoptions-=c,r,o

" Numbering and Indent
set number
set relativenumber
set wrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set hlsearch
set incsearch
set linebreak
set cursorline

" File Settings
set fileformat=unix
set fileformats=unix
set fileencoding=utf-8
set fileencodings=utf-8
set encoding=utf-8
set showcmd
set backupdir=./.backup,.,/tmp
set directory=.,./.backup,/tmp
set autochdir
set nobackup
set nowritebackup

" List Chars
set list
set listchars=trail:.
set showbreak=\\

" Completion
set complete=.,w,b,u,k
set completeopt=menuone,noselect

" Set the cursor on insert mode
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\e[6 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[2 q"
endif

" Presistent Undo
if has('persistent_undo')
  set undofile
  set undodir=$HOME/.vim/undo
  set undolevels=2500
endif
