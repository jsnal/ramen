" Exclude certain filetypes from changing the statusline
function! s:check_ft()
  if &ft =~ 'nerdtree'
    return 1
  endif
endfunction

" Window or Buffer Focsed StatusLine
function! statusline#focus() abort

  if s:check_ft() == 1
    return
  endif

  setlocal statusline=%#FileHeader#
  setlocal statusline+=\ %{expand('%:h')}/
  setlocal statusline+=%#FileTail#
  setlocal statusline+=%t
  setlocal statusline+=%#StatusLine#
  setlocal statusline+=\ %r%m
  setlocal statusline+=%=\ %y
  setlocal statusline+=%=\ (%l/%L)
  setlocal statusline+=\ %p%%
endfunction

" Window or Buffer Blurred StatusLine
function! statusline#blur() abort

  if s:check_ft() == 1
    return
  endif

  setlocal statusline=\ %{expand('%:h')}/
  setlocal statusline+=%t\ %y
endfunction
