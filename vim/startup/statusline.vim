let g:currentmode={ 'n' : 'Normal ', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V-Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}

function! ModeCurrent() abort
  let l:modecurrent = mode()
  let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V-Block '))
  let l:current_status_mode = l:modelist
  hi! StatusLine ctermfg=white
  return l:current_status_mode
endfunction

" Jellybean Statusline
set statusline=\ %f
set statusline+=\ %r%m
set statusline+=%=\ %y
set statusline+=%=\ (%l/%L)
set statusline+=\ %p%%
