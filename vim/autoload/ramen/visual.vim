" See https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.vim/autoload/wincent/mappings/visual.vim

function! s:visual()
  return visualmode() == 'V'
endfunction

function! s:move(address, should_move)
  if s:visual() && a:should_move
    execute "'<,'>move " . a:address
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction

function! ramen#visual#move_up() abort range
  let l:count=v:count ? -v:count : -1
  let l:max=(a:firstline - 1) * -1
  let l:movement=max([l:count, l:max])
  let l:address="'<" . (l:movement - 1)
  let l:should_move=l:movement < 0
  call s:move(l:address, l:should_move)
endfunction

function! ramen#visual#move_down() abort range
  let l:count=v:count ? v:count : 1
  let l:max=line('$') - a:lastline
  let l:movement=min([l:count, l:max])
  let l:address="'>+" . l:movement
  let l:should_move=l:movement > 0
  call s:move(l:address, l:should_move)
endfunction
