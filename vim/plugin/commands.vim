command! Wq :wq
command! W :w
command! Q :q
command! Wa :wa
command! Qa :qa
command! Wqa :wqa
command! WW :w !sudo dd of=%
command! -nargs=+ -complete=shellcmd Man call ramen#man#get_page(<f-args>)
