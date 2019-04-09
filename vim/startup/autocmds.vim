" Folds
au BufWinLeave * silent mkview
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set relativenumber
  autocmd WinLeave * set nonumber | set norelativenumber
augroup END

" Markdown, txt, LaTeX
au BufReadPost,BufNewFile *.md,*.tex call functions#spell() |  Goyo 125
" load buffer with possible vim/zsh files to edit
au BufReadPost,BufNewFile *.zshrc,zshrc call functions#openwithbuffer("~/i3wm/zsh/*.zsh")
au BufReadPost,BufNewFile *.vimrc,vimrc call functions#openwithbuffer("~/i3wm/vim/startup/*.vim")

" Enter and Leave Goyo
autocmd! User GoyoEnter call functions#goyo_enter()
autocmd! User GoyoLeave call functions#goyo_leave()

" delete whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" remove new line auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType netrw setl bufhidden=wipe
" close nerdtree if last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
