" Handle searching through codebase using Ag
function! pick#aglinehandler(selection) abort
  let parts = split(a:selection, ':')
  return {'filename': parts[0], 'line': parts[1], 'column': parts[2]}
endfunction

" Format a simply statusline for picker
function! pick#statusline() abort
  hi! LeftBlock  ctermbg=9 ctermfg=15
  hi! LeftSymbol ctermfg=9

  " Left Side
  setlocal statusline=%#LeftBlock#
  setlocal statusline+=\ Picker\ "
  setlocal statusline+=%#LeftSymbol#
  setlocal statusline+=

  " Right Side
  setlocal statusline+=%=%#RightSymbol#
  setlocal statusline+=
  setlocal statusline+=%#RightBlock#
  setlocal statusline+=\ "
  setlocal statusline+=\ "
endfunction
