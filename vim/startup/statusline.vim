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

" Get the current mode of the vim buffer
function! statusline#mode_current() abort
	return get(g:currentmode, mode(), 'v·block')
endfunction

" Change the color of the statusline based on the current mode of the buffer
function! statusline#update_mode_color() abort
	if (mode() =~# '\v(n|no)')
		exe 'hi! ModeColor ctermfg=248'
	elseif (mode() =~# '\v(v|V)' || get(g:currentmode, mode(), 'v·block') ==# 'v·block')
		exe 'hi! ModeColor ctermfg=6'
	elseif (mode() ==# 'i')
		exe 'hi! ModeColor ctermfg=2'
	else
		exe 'hi! ModeColor ctermfg=5'
	endif

	return ''
endfunction

" Window or Buffer Focsed StatusLine
function! statusline#focus() abort

  if s:check_ft() == 1
    return
  endif

	setlocal statusline=%{statusline#update_mode_color()}
	setlocal statusline+=%#ModeBracketColor#[
	setlocal statusline+=%#ModeColor#%{statusline#mode_current()}
	setlocal statusline+=%#ModeBracketColor#]
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
