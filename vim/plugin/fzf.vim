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
  highlight fzf ctermfg=253 ctermbg=235 cterm=NONE
  highlight accent ctermfg=167 ctermbg=0
  setlocal statusline=%#fzf#\>\ fzf
endfunction

nnoremap <silent> <Space><Space> :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('fzf#bufopen'),
      \   'options': '--prompt=">>> " --color fg:-1,bg:-1,hl:214,fg+:-1,bg+:235,hl+:214 --color info:150,prompt:167,spinner:150,pointer:167,marker:0',
      \   'right':   '~25%'
      \ })<CR>
