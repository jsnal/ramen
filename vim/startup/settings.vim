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

" Presistent Undo
if has('persistent_undo')
  set undodir=$HOME/.vim_undo
  set undolevels=5000
  set undofile
endif

" FZF Settings
let g:fzf_nvim_statusline = 0

" Indent Line
if &fileencoding == 'utf-8'
  let g:indentLine_char = '│'
else
  let g:indentLine_char = '|'
endif

" Matchup
let g:matchup_matchpref = {
      \ 'html':       { 'tagnameonly': 1,  },
      \ 'htmldjango': { 'tagnameonly': 1,  },
      \ 'javascript': { 'tagnameonly': 1,  },
      \}

" Dirvish
let g:dirvish_mode = ':sort ,^\v(.*[\/])|\ze,'
