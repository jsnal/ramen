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

" TODO: Put this into a full fledged function
" vimgrep /\<TODO\>/j vim/** | :cope
