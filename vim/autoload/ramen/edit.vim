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


" Move visually selected lines up
function! ramen#edit#move_up() abort range
  let l:count=v:count ? -v:count : -1
  let l:max=(a:firstline - 1) * -1
  let l:movement=max([l:count, l:max])
  let l:address="'<" . (l:movement - 1)
  let l:should_move=l:movement < 0
  call s:move(l:address, l:should_move)
endfunction


" Move visually selected lines down
function! ramen#edit#move_down() abort range
  let l:count=v:count ? v:count : 1
  let l:max=line('$') - a:lastline
  let l:movement=min([l:count, l:max])
  let l:address="'>+" . l:movement
  let l:should_move=l:movement > 0
  call s:move(l:address, l:should_move)
endfunction


" Make editing easier by filling the known path to the current file
function! ramen#edit#open(type) abort
  let l:path = expand('%:h')
  let l:trail = "/"

  if empty(l:path)
    let l:trail = ""
  endif

  call inputsave()
  let l:file = input(a:type . ": ", l:path . l:trail, "file")
  call inputrestore()

  " Check that the path isn't empty, './' or already opened
  if empty(l:file) || l:file ==# './' || l:file ==# expand("%")
    return
  endif

  execute a:type l:file
endfunction


" Spell Check
function! ramen#edit#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spelllang=en
    setlocal encoding=utf-8
  endif
endfunction


" Plaintext mode for markdown files mainly
function! ramen#edit#plain_text() abort
  setlocal formatoptions+=r
  setlocal textwidth=0
  setlocal wrap
  setlocal wrapmargin=0

  call ramen#edit#spell()
endfunction
