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
	setlocal statusline+=\ [%{statusline#modecurrent()}]
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
	return toupper(get(g:currentmode, mode(), 'V·Block'))
endfunction

" See :help mode() to see a list of all currentmode names
let g:currentmode = {
    \ 'n'  : 'N',
    \ 'no' : 'N·Operator Pending',
    \ 'v'  : 'V',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim·Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}
