" Get current git branch
function! git#branch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Set the statusline to GitBranch()
function! git#statusline()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' ['.l:branchname.']':''
endfunction

" Create a scratchpad with a given command
" TODO: Make this a universal function. Not just for git filetypes.
function! git#scratch(command)
  let buffername = 'gitpad'
  let bnr = bufwinnr(buffername)

  if bnr > 0
    " Switch to the already opened buffer
    execute 'sbuffer ' . buffername
  else
    " Setup the new buffer
    execute 'new ' . buffername
    noswapfile
    setlocal buftype=nofile filetype=git
  endif

  " Get the output of the given command
  let output = system(a:command)

  " Clear out anything already in the buffer
  normal! ggdG

  " Append it to the buffer
  call append(0, split(output, '\v\n'))

  " Retab the buffer and goto the top
  retab
  normal! gg
endfunction
