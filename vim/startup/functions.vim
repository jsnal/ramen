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
    hi SpellBad cterm=underline
    setlocal spelllang=en
  endif
endfunction

" Opens file with predefined files
function! functions#openwithbuffer(path) abort
  for f in split(glob(a:path), '\n')
    exe 'badd' f
  endfor

  filetype detect
endfunction
