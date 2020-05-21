" Get current git branch
function! git#branch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Format the output for a statusline
function! git#statusline()
  let l:branchname = git#branch()
  return strlen(l:branchname) > 0?' ['.l:branchname.']':''
endfunction
