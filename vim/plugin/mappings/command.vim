" Frequently mistyped commands
command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Qa :qa
command! Wqa :wqa
command! WW :w !sudo dd of=%

" Make the command line binding more like my shell
cnoremap <C-j> <S-Right><C-w>
cnoremap <C-b> <S-Left>
