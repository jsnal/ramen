" Get current git branch
function! git#branch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Set the statusline to GitBranch()
function! git#statusline()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' ['.l:branchname.']':''
endfunction
