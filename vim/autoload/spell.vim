" Spell Check
function! spell#options() abort
  if has('syntax')
    setlocal spell
    setlocal spelllang=en
    setlocal encoding=utf-8
    setlocal spellfile=$HOME/.vim/spell/en.utf-8.add
  endif
endfunction

" Plaintext mode for markdown files mainly
function! spell#plaintext() abort
  setlocal formatoptions+=r
  setlocal textwidth=0
  setlocal wrap
  setlocal wrapmargin=0

  call spell#options()
endfunction
