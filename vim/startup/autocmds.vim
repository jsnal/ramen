" Folds
au BufWinLeave * silent mkview
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

" Markdown, txt, LaTeX
au BufReadPost,BufNewFile *.md,*.tex call functions#plaintext()

" load buffer with possible vim/zsh files to edit
if isdirectory($HOME . "/i3wm")
  au BufReadPost,BufNewFile *.zshrc,zshrc call functions#openwithbuffer("~/i3wm/zsh/*.zsh")
  au BufReadPost,BufNewFile *.vimrc,vimrc call functions#openwithbuffer("~/i3wm/vim/startup/*.vim")
endif

" Enter and Leave Goyo
autocmd! User GoyoEnter call goyo#goyo_enter()
autocmd! User GoyoLeave call goyo#goyo_leave()

" delete whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" remove new line auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType netrw setl bufhidden=wipe

" close nerdtree if last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Override Default fzf statusline
autocmd! User FzfStatusLine call fzf#fzf_statusline()

" Remove highlighting on insert mode
autocmd InsertEnter * :let @/=""

" Enable coc.nvim when CursorHold is enabled, 500 Milliseconds
if $VIM_COC == 'true'
  augroup load_coc
    autocmd!
    autocmd CursorHold * call plug#load('coc.nvim') | autocmd! load_coc
  augroup END
endif

" Set tabs to 4 spaces in python
autocmd Filetype *      set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd BufEnter *.py   set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" Set StatusLine
autocmd BufLeave,WinLeave * call statusline#blur()
autocmd BufEnter,WinEnter * call statusline#focus()
