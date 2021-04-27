if has('autocmd')
  augroup GeneralAutocmds
    autocmd!

    " Enable UltiSnips and the LSP when CursorHold is enabled, 2000 Milliseconds
    autocmd CursorHold,CursorHoldI * call plug#load('LanguageClient-neovim')

    if has('python') || has('python3')
      autocmd CursorHold,CursorHoldI * call plug#load('UltiSnips')
    endif


    " Save/Restore folds and cursor position
    if has('mksession')
      autocmd BufWinLeave *.* call ramen#fold#mkview()
      autocmd BufWinEnter *.* call ramen#fold#loadview()
    endif

    " Blur and focus the statusline based on the current window
    if has('statusline')
      autocmd BufEnter,FocusGained,VimEnter,WinEnter * call ramen#statusline#focus()
      autocmd FocusLost,WinLeave * call ramen#statusline#blur()
    endif

    " delete whitespace on save
    let s:whitespace_ignore = ['gitcommit', 'diff']
    autocmd BufWritePre * if index(s:whitespace_ignore, &ft) < 0 | %s/\s\+$//e

    " Remove autocommenting on newlines
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

    " Keep splits equal at all times
    autocmd VimResized * wincmd =

    " Set code line length limits
    autocmd Filetype c,cpp,java,javascript,python setlocal colorcolumn=80
  augroup END
endif
