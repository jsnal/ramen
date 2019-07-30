let s:failed = 0

function! s:echowarn(msg)
  echohl WarningMsg
  echo "Warning:"
  echohl None
  echon ' ' a:msg
endfunction

function! s:make_check(feature)
  if ! has(a:feature)
    call s:echowarn("vim is not compiled with " . a:feature)
    let s:failed += 1
  endif
endfunction

function! health#check() abort
  " Check python versions
  call s:make_check('python3')
  call s:make_check('python')

  " Check clipboard support
  call s:make_check('clipboard')
  call s:make_check('xterm_clipboard')

  " Check for 256 Colors
  if &t_Co != 256
    call s:echowarn('t_Co is not set to 256. Is this not a 256 color terminal?')
  endif

  echon "\n\nHealth check done: " . s:failed . " problems found."
endfunction
