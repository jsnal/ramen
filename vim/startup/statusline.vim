" Exclude certain filetypes from changing the statusline
function! s:check_ft()
  if &ft =~ 'nerdtree'
    return 1
  endif
endfunction

" Remove the ./ if it is a root level file
function! statusline#get_file_header()
  let s:file_header = expand('%:h') . '/'
  return substitute(s:file_header, '^\.\/\|^\/', '\1', '')
endfunction

" Window or Buffer Focsed StatusLine
function! statusline#focus() abort

  if s:check_ft() == 1
    return
  endif

	setlocal statusline=%#ModeColor#
	setlocal statusline+=[%{statusline#modecurrent()}]
	setlocal statusline+=%#FileHeader#
  setlocal statusline+=\ %{statusline#get_file_header()}
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

  setlocal statusline=\ %{statusline#get_file_header()}
  setlocal statusline+=%t\ %y
  setlocal statusline+=%=\ (%l/%L)
endfunction

function! statusline#modecurrent() abort
	return get(g:currentmode, mode(), 'v·block')
endfunction

" See :help mode() to see a list of all currentmode names
let g:currentmode = {
    \ 'n'  : 'normal',
    \ 'no' : 'n·operator pending',
    \ 'v'  : 'visual',
    \ 'V'  : 'v·line',
    \ '^V' : 'v·block',
    \ 's'  : 'select',
    \ 'S'  : 's·line',
    \ '^S' : 's·block',
    \ 'i'  : 'insert',
    \ 'R'  : 'replace',
    \ 'Rv' : 'v·replace',
    \ 'c'  : 'command',
    \ 'cv' : 'vim·ex',
    \ 'ce' : 'ex',
    \ 'r'  : 'prompt',
    \ 'rm' : 'more',
    \ 'r?' : 'confirm',
    \ '!'  : 'shell',
    \ 't'  : 'terminal'
    \}
