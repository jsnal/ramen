function! s:get_args(section, name) abort
  if a:section == ''
    return '-w '.a:name
  endif
  return '-s '.a:section.' -w '.a:name
endfunction

" Return 0 if it's an invalid manpage
function! s:find_page(section, name) abort
  let l:page = system("man ".s:get_args(a:section, a:name))
  if l:page !~ "^/"
    if matchstr(l:page, " [^ ]*$") !~ "^ /"
      return 0
    endif
  endif
  return l:page
endfunction

function! ramen#man#get_page(...) abort
  if a:0 >= 2
    let l:section = a:1
    let l:name = a:2
  elseif a:0 >= 1
    let l:section = ""
    let l:name = a:1
  else
    return
  endif

  let l:page = s:find_page(l:section, l:name)

  if l:page =~ 0
    echo "Cannot find page `".l:name."'."
    return
  endif

  " TODO: Hard coding the env command isn't the best since it will break on
  "       some systems but it will work fine for now.
  let l:man_cmd = 'env -u cat man ' . l:section . ' ' . l:name . ' | col -b'

  " Display it in a temp scratchpad buffer
  call ramen#buffer#scratchpad(l:man_cmd)


  " Remove blank lines from top and bottom and goto the top of the buffer
  while line('$') > 1 && getline(1) =~ '^\s*$'
    silent keepj norm! ggdd
  endwhile
  while line('$') > 1 && getline('$') =~ '^\s*$'
    silent keepj norm! Gdd
  endwhile
  silent norm! gg

  setlocal filetype=man
  setlocal wrap
endfunction
