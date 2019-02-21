command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Qa :qa
command! Wqa :wqa
cabbrev fzf FZF
command! WW :w !sudo dd of=%
command! -bang -nargs=? -complete=dir HFiles
      \ call fzf#vim#files(<q-args>, {'source': 'find . -path "*/\.*" -prune -o -type f ! -name "*~" -print -o -type l -print'}, <bang>0)
