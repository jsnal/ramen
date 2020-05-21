if has('autocmd')
  augroup GeneralAutocmds
    autocmd!

    " Enable UltiSnips and the LSP when CursorHold is enabled, 500 Milliseconds
    autocmd CursorHold * call plug#load('UltiSnips', 'LanguageClient-neovim')

    " Save/Restore folds and cursor position
    if has('mksession')
      autocmd BufWinLeave *.* call fold#mkview()
      autocmd BufWinEnter *.* call fold#loadview()
    endif

    " Blur and focus the statusline based on the current window
    if has('statusline')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * call statusline#focus()
      autocmd FocusLost,WinLeave * call statusline#blur()
    endif

    " delete whitespace on save
    let s:whitespace_ignore = ['gitcommit', 'diff']
    autocmd BufWritePre * if index(s:whitespace_ignore, &ft) < 0 | %s/\s\+$//e
  augroup END
endif
