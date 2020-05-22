" Remove the ./ if it is a root level file
function! ramen#statusline#get_file_header()
  let s:file_header = expand('%:h') . '/'
  return substitute(s:file_header, '^\.\/\|^\/', '\1', '')
endfunction

" Get the current mode of the vim buffer
function! ramen#statusline#mode_current() abort
  return get(g:currentmode, mode(), 'v·block')
endfunction

" Change the color of the statusline based on the current mode of the buffer
function! ramen#statusline#update_mode_color() abort
  if (mode() =~# '\v(n|no)')
    hi! LeftBlock  ctermbg=243 ctermfg=15
    hi! LeftSymbol ctermfg=243
  elseif (mode() =~# '\v(v|V)' || get(g:currentmode, mode(), 'v·block') ==# 'v·block')
    hi! LeftBlock ctermbg=32 ctermfg=15
    hi! LeftSymbol ctermfg=32
  elseif (mode() ==# 'i')
    hi! LeftBlock ctermbg=172 ctermfg=15
    hi! LeftSymbol ctermfg=172
  else
    hi! LeftBlock ctermbg=9
    hi! LeftSymbol ctermfg=9
  endif

  return ''
endfunction

" Window or Buffer Focsed StatusLine
function! ramen#statusline#focus() abort
  " Left Side
  setlocal statusline=%{ramen#statusline#update_mode_color()}
  setlocal statusline+=%#LeftBlock#
  setlocal statusline+=\ %{ramen#statusline#mode_current()}\ "
  setlocal statusline+=%#LeftSymbol#
  setlocal statusline+=
  setlocal statusline+=%#FileHeader#
  setlocal statusline+=\ %{ramen#statusline#get_file_header()}
  setlocal statusline+=%#FileTail#
  setlocal statusline+=%t
  setlocal statusline+=%#StatusLine#
  setlocal statusline+=\ %r%m

  " Right Side
  setlocal statusline+=%=%#RightSymbol#
  setlocal statusline+=
  setlocal statusline+=%#RightBlock#
  setlocal statusline+=\ %{&filetype}
  setlocal statusline+=\ %l/%L
  setlocal statusline+=\ "
endfunction

" Window or Buffer Blurred StatusLine
function! ramen#statusline#blur() abort
  " Put spaces where the LeftBlock would be so it appears seamless
  setlocal statusline=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "
  setlocal statusline+=\ "

  " Actual statusline content
  setlocal statusline+=%#FileHeader#
  setlocal statusline+=\ %{ramen#statusline#get_file_header()}
  setlocal statusline+=%t
  setlocal statusline+=%=\ %{&filetype}
  setlocal statusline+=\ %l/%L
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
