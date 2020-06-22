" Setup Colorscheme
set background=dark

if has('syntax')
  syntax on
endif

if has('gui_running')
  silent! colorscheme slate
else
  silent! colorscheme serape
  hi Normal  ctermbg=none
  hi LineNr  ctermbg=none
  hi NonText ctermbg=none
endif

" Automatically try to find the filetype
filetype plugin on

" General
set nomodeline
set laststatus=2
set backspace=indent,eol,start
set path+=**
set wildmenu
set wildmode=longest:full,full
set shortmess=c
set cmdheight=1
set showmode
set splitbelow splitright
set ignorecase smartcase
set hidden
set updatetime=2000
set noshowmode
set switchbuf=useopen
set belloff=all
set shell=sh
set colorcolumn=80

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
set cursorline

" File Settings
set fileformat=unix
set fileformats=unix
set fileencoding=utf-8
set fileencodings=utf-8
set encoding=utf-8
set showcmd
set autochdir

" List Chars
set list
set listchars=trail:•

" Line Break
if has('linebreak')
  set linebreak
  let &showbreak='↳ '
endif

" Allow cursor movement where there is no text in visual block mode
if has('virtualedit')
  set virtualedit=block
endif

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
  if exists('$SUDO_USER')
    set noundofile
  else
    set undofile
    set undodir=$HOME/.vim/tmp/undo
    set undolevels=2500
  endif
endif

" Mksession view
if has('mksession')
  set viewdir=$HOME/.vim/tmp/view
  set viewoptions=cursor,folds
endif

" Backups
if exists('$SUDO_USER')
  set nobackup
  set nowritebackup
else
  set backupdir=$HOME/.vim/tmp/backup
  set backupdir+=.
endif

" Swap files
if exists('$SUDO_USER')
  set noswapfile
else
  set directory=$HOME/.vim/tmp/swap//
  set directory+=.
endif
