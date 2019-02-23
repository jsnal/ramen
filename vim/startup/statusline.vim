let g:currentmode={ 'n' : 'Normal ', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V-Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}

function! ModeCurrent() abort
  let l:modecurrent = mode()
  let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V-Block '))
  let l:current_status_mode = l:modelist
  hi! StatusLine ctermfg=white
  return l:current_status_mode
endfunction

set statusline=\ %{ModeCurrent()}>>
set statusline+=\ %#PmenuSel#
set statusline+=\ %r%m[%n]\ %f
set statusline+=\ %#LineNr#
set statusline+=%=%#PmenuSel#
" set statusline+=%=%{StatuslineGit()}
set statusline+=%=\ %P\ %p%%
set statusline+=%=\ (%l/%L)
set statusline+=\ <<

hi statusline guibg=black ctermfg=white guifg=white ctermbg=none
