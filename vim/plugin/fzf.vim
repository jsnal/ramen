function! fzf#fzf_statusline()
  highlight fzf ctermfg=253 ctermbg=235 cterm=bold
  highlight accent ctermfg=167 ctermbg=0
  setlocal statusline=%#fzf#\[fzf]
endfunction

let g:fzf_layout = { 'down': '~50%' }

command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'options': ['--preview', '']}, <bang>0)
command! -bang -nargs=? -complete=dir Ag call fzf#vim#ag(<q-args>, {'options': ['--preview', '']}, <bang>0)
