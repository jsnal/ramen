" Remove the ./ if it is a root level file
function! ramen#statusline#get_file_header()
  let s:file_header = expand('%:h') . '/'
  return substitute(s:file_header, '^\.\/\|^\/', '\1', '')
endfunction

" Get the current mode of the vim buffer
function! ramen#statusline#mode_current() abort
  return get(g:currentmode, mode(), 'v·block')
endfunction

" Window or Buffer Focsed StatusLine
function! ramen#statusline#focus() abort
  setlocal statusline=\ %#FileHeader#
  setlocal statusline+=%{ramen#statusline#get_file_header()}
  setlocal statusline+=%#FileTail#
  setlocal statusline+=%t
  setlocal statusline+=%#StatusLine#
  setlocal statusline+=\ %r%m

  " Right Side
  setlocal statusline+=%=
  setlocal statusline+=\ %{&filetype}
  setlocal statusline+=\ %l/%L
  setlocal statusline+=\ %c
  setlocal statusline+=\ "
endfunction

" Window or Buffer Blurred StatusLine
function! ramen#statusline#blur() abort
  " Actual statusline content
  setlocal statusline=%#StatusLineNC#
  setlocal statusline+=\ %{ramen#statusline#get_file_header()}
  setlocal statusline+=%t
  setlocal statusline+=%=\ %{&filetype}
  setlocal statusline+=\ %l/%L
  setlocal statusline+=\ %c
  setlocal statusline+=\ "
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
