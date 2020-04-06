" Get current git branch
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Set the statusline to GitBranch()
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' ['.l:branchname.']':''
endfunction

function! GitDiff()
  silent write
  silent execute '!git diff --color=always -- ' . expand('%:p') . ' | less --RAW-CONTROL-CHARS'
  redraw!
endfunction
