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

  echon "Running health check on Vim " . v:version . "\n\n"

  " Number of threats found
  let s:failed = 0

  " Check python versions
  call s:make_check('python3')
  call s:make_check('python')

  " Check clipboard support
  call s:make_check('clipboard')
  call s:make_check('xterm_clipboard')

  " Check for 256 Colors
  if &t_Co != 256
    call s:echowarn('t_Co is not set to 256. Is this not a 256 color terminal?')
    let s:failed += 1
  endif

  if v:version < 800
    call s:echowarn('asynchronous tasks is not supported in this verion of vim')
    let s:failed += 1
  endif

  echon "\n\nHealth check done: " . s:failed . " threats found"
endfunction
