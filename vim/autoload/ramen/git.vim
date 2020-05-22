" Get current git branch
function! ramen#git#branch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Format the output for a statusline
function! ramen#git#statusline()
  let l:branchname = ramen#git#branch()
  return strlen(l:branchname) > 0?' ['.l:branchname.']':''
endfunction
