" Remove the ./ if it is a root level file
function! ramen#statusline#get_file_header()
  let s:file_header = expand('%:h') . '/'
  return substitute(s:file_header, '^\.\/\|^\/', '\1', '')
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
