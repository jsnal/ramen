command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Qa :qa
command! Wqa :wqa
cabbrev fzf FZF
command! WW :w !sudo dd of=%
command! -bang -nargs=? -complete=dir HFiles
      \ call fzf#vim#files(<q-args>, {
      \ 'options': '--prompt=">>> " --color fg:-1,bg:-1,hl:230,fg+:-1,bg+:233,hl+:229 --color info:150,prompt:167,spinner:150,pointer:167,marker:0',
      \ 'source': 'find . -path "*/\.*" -prune -o -type f ! -name "*~" ! -name "*.class" -print -o -type l -print'}, <bang>0)
