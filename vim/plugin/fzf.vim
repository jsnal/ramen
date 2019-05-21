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

nnoremap <silent> <Space><Space> :call fzf#run({
      \   'source':  reverse(<sid>buflist()),
      \   'sink':    function('functions#bufopen'),
      \   'options': '--prompt=">> " --color fg:-1,bg:-1,hl:230,fg+:167,bg+:233,hl+:229 --color info:150,prompt:110,spinner:150,pointer:167,marker:0 +m',
      \   'left':   '~25%'
      \ })<CR>
