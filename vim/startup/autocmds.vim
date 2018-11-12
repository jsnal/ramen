" Folds
au BufWinLeave * silent mkview
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent mkview
  autocmd BufWinEnter * silent loadview
augroup END

" Markdown, txt, LaTeX
au BufReadPost,BufNewFile *.md,*.txt,*.tex call functions#spell() |  Goyo 125 | normal zR
