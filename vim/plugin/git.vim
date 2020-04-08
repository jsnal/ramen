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
" TODO: Make this smarter by killing it if you are already in the buffer
function! git#scratch(command)
  " Get the output of the given command and setup the buffer
  let output = system(a:command)
  new [scratchpad]
  noswapfile
  setlocal buftype=nofile bufhidden=hide filetype=git

  " Clear out anything already in the buffer
  normal! ggdG

  " Append it to the buffer
  call append(0, split(output, '\v\n'))

  " Retab the buffer and goto the top
  retab
  normal! gg
endfunction
