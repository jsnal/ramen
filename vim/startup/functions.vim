" Spell Check
function! functions#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spelllang=en
    setlocal encoding=utf-8
    setlocal spellfile=~/.vim/spell/en.utf-8.add
  endif
endfunction

" Plaintext mode for markdown files mainly
function! functions#plaintext() abort
  setlocal formatoptions+=r
  setlocal textwidth=0
  setlocal wrap
  setlocal wrapmargin=0

  call functions#spell()
endfunction

" Opens file with predefined files
function! functions#openwithbuffer(path) abort
  for f in split(glob(a:path), '\n')
    exe 'badd' f
  endfor

  filetype detect
endfunction

" Attempt to switch to an open buffer or open
" that buffer in a horizontal split.
function! functions#choosebuffer(buffername)
  let buf_exist = bufexists(str2nr(a:buffername))
  let buf_open = bufwinnr(a:buffername)

  if buf_exist > 0
    if buf_open > 0
    execute 'sbuffer ' . a:buffername
    else
      silent execute 'split ' . a:buffername
    endif
  else
    echo a:buffername . ' is not existent'
  endif
endfunction
