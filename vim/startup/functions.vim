" Better Fold Method
function! functions#Betterfdm()
  if &foldmethod =~ "marker"
    set foldmethod=marker
  else
    set foldmethod=indent
  endif
endfunction
call functions#Betterfdm()

" Spell Check
function! functions#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spellfile=~/.vim/spell/en.utf-7.add
    hi SpellBad cterm=underline
    setlocal spelllang=en
  endif
endfunction

" Opens file with predefined files
function! functions#openwithbuffer(path) abort
  for f in split(glob(a:path), '\n')
    exe 'badd' f
  endfor

  filetype detect
endfunction

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?' ('.l:branchname.')':''
endfunction

function! functions#focused_win()
  set nocul
endfunction

function! functions#non_focused_win()
  set nocul
endfunction

function! functions#focused_buffer()
  let buffers = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  let j = 0
  for i in buffers
    let j = i
  endfor
endfunction
