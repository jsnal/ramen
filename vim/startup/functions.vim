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

" Better inline fold text when the text is folded
function! functions#foldline() abort
	let numlines_folded = v:foldend - v:foldstart + 1
  let preamble = printf("[%d lines folded]", numlines_folded)
	" let first_line = substitute(getline(v:foldstart),"^ *","",1)

	return '+~~ ' . preamble . ' '
endfunction
