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

" NERD Tree like Files Exlporer
" Settings in settings.vim
function! functions#ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      close
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore 
    let t:expl_buf_num = bufnr("%")
  endif
endfunction

" Spell Check
function! functions#spell() abort
  if has('syntax')
    setlocal spell
    "setlocal spellfile=~/.vim/spell/en.utf-8.add
    hi SpellBad cterm=underline
    setlocal spelllang=en
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
        \   'options': '+m' })
endfunction
