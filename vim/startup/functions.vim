" Better Fold Method
function! functions#Betterfdm()
  if &foldmethod =~ "marker"
    set foldmethod=marker
  else
    set foldmethod=indent
  endif
endfunction
call functions#Betterfdm()

" Spell Check
function! functions#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spellfile=~/.vim/spell/en.utf-7.add
    setlocal spelllang=en
    setlocal formatoptions+=r
  endif
endfunction

" Opens file with predefined files
function! functions#openwithbuffer(path) abort
  for f in split(glob(a:path), '\n')
    exe 'badd' f
  endfor

  filetype detect
endfunction
