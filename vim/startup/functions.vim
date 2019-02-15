" FZF Buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! functions#bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Space><Space> :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('functions#bufopen'),
      \   'options': '+m',
      \   'down':    len(<sid>buflist()) + 2
      \ })<CR>

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

" Force Goyo to quite vim on q or q!
function! functions#goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! functions#goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

" Opens file with predefined files
function! functions#openwithbuffer(path) abort
  for f in split(glob(a:path), '\n')
    exe 'badd' f
  endfor

  call fzf#run({
        \   'source':  <sid>buflist(),
        \   'sink':    function('functions#bufopen'),
        \   'down':    len(<sid>buflist()) + 2,
        \   'options': '+m' })
  filetype detect
endfunction
