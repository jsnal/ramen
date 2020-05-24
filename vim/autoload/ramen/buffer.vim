" Attempt to switch to an open buffer or open that buffer in a horizontal split
function! ramen#buffer#switch(buffername)
  let buf_exist = bufexists(str2nr(a:buffername))
  let buf_open = bufwinnr(a:buffername)

  if buf_exist > 0
    if buf_open > 0
    execute 'sbuffer ' . a:buffername
    else
      silent execute 'split ' . a:buffername
    endif
  else
    echo a:buffername . ' is not existent'
  endif
endfunction

" Create a scratchpad with a given system command
function! ramen#buffer#scratchpad(command)
  let s:buffername = 'scratchpad'

  if bufwinnr(s:buffername) > 0
    " Switch to the already opened buffer
    execute 'sbuffer ' . s:buffername
  else
    " Setup the new buffer
    execute 'new ' . s:buffername
    execute 'resize ' . string(&lines * 0.70)
    noswapfile
    setlocal buftype=nofile nowrap
  endif

  " Get the output of the given command
  let s:output = system(a:command)

  " Clear out anything already in the buffer
  normal! ggdG

  " Append it to the buffer
  call append(0, split(s:output, '\v\n'))

  " Retab the buffer, goto the top and set the filetype
  retab
  normal! gg
  filetype detect
endfunction

" Opens file with predefined files
function! ramen#buffer#listopen(path)
  for f in split(glob(a:path), '\n')
    execute 'badd' f
  endfor

  filetype detect
endfunction
