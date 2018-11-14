" Folds
au BufWinLeave * silent mkview
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent mkview
  autocmd BufWinEnter * silent loadview
augroup END

" Markdown, txt, LaTeX
au BufReadPost,BufNewFile *.md,*.txt,*.tex call functions#spell() |  Goyo 125 | normal zR
" zshrc
au BufReadPost,BufNewFile *.zshrc,zshrc call functions#openwithbuffer("~/i3wm/zsh/*.zsh")
" vimrc
au BufReadPost,BufNewFile *.vimrc,vimrc call functions#openwithbuffer("~/i3wm/vim/startup/*.vim") | filetype detect
" Enter and Leave Goyo
autocmd! User GoyoEnter call functions#goyo_enter()
autocmd! User GoyoLeave call functions#goyo_leave()
