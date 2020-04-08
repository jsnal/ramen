command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Qa :qa
command! Wqa :wqa
command! WW :w !sudo dd of=%
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'down': '~20%'}, <bang>0)
command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, {'left': '~20%', 'options': ['--preview', '']}, <bang>0)

cabbrev fzf FZF
cabbrev help vert help
