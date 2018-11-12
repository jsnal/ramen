let g:currentmode={ 'n' : 'Normal ', 'no' : 'N·Operator Pending ', 'v' : 'Visual ', 'V' : 'V·Line ', '^V' : 'V·Block ', 's' : 'Select ', 'S': 'S·Line ', '^S' : 'S·Block ', 'i' : 'Insert ', 'R' : 'Replace ', 'Rv' : 'V·Replace ', 'c' : 'Command ', 'cv' : 'Vim Ex ', 'ce' : 'Ex ', 'r' : 'Prompt ', 'rm' : 'More ', 'r?' : 'Confirm ', '!' : 'Shell ', 't' : 'Terminal '}

function! ModeCurrent() abort
  let l:modecurrent = mode()
  let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
  let l:current_status_mode = l:modelist
  return l:current_status_mode
endfunction

set statusline=\ %{ModeCurrent()}>>\ 
set statusline+=%#PmenuSel#
set statusline+=\ %r%m[%n]\ %f\ 
set statusline+=%#LineNr#
set statusline+=%=%#PmenuSel#
set statusline+=%=\ %P\ %p%%
set statusline+=%=\ (%l/%L)
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=\ <<

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=blue ctermfg=blue guifg=white ctermbg=white
  elseif a:mode == 'r'
    hi statusline guibg=Purple ctermfg=5 guifg=Black ctermbg=0
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
hi statusline guibg=DarkGrey ctermfg=darkgrey guifg=White ctermbg=white
