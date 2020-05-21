let g:UltiSnipsExpandTrigger = "<c-u>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsSnippetDirectories = [$HOME . '/.vim/ultisnips']

inoremap <silent> <expr> <cr> mucomplete#ultisnips#expand_snippet("\<cr>")
