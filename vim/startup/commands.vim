command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Qa :qa
command! Wqa :wqa
cabbrev fzf FZF
cabbrev help vert help
command! WW :w !sudo dd of=%
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'down':'~20%'}, <bang>0)
