" FZF Buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! fzf#bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

function! fzf#fzf_statusline()
  highlight fzf ctermfg=253 ctermbg=235 cterm=bold
  highlight accent ctermfg=167 ctermbg=0
  setlocal statusline=%#fzf#\[fzf]
endfunction

nnoremap <silent> <Space><Space> :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('fzf#bufopen'),
      \   'options': $FZF_DEFAULT_OPTS,
      \   'right':   '~25%'
      \ })<CR>
