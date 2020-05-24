" Leader
noremap <Leader>c :TComment<CR>
noremap <Leader>l :nohlsearch<CR>
noremap <Leader>a :bprev<CR>
noremap <Leader>s :bnext<CR>
noremap <Leader>d :bd<CR>
noremap <Leader>rl :source %<CR>

" Git Mappings
noremap <Leader>gg :call ramen#buffer#switch('scratchpad')<CR>
noremap <Leader>gf :call ramen#buffer#scratchpad('git diff '. expand('%:p'))<CR>
noremap <Leader>gd :call ramen#buffer#scratchpad('git diff')<CR>
noremap <Leader>gs :call ramen#buffer#scratchpad('git status')<CR>

" TODO: Fix the error thrown when trying to switch from a git log buffer
noremap <Leader>gl :call ramen#buffer#scratchpad('git log -50')<CR>

" Language Server
noremap <Leader>rd :call LanguageClient_textDocument_definition()<CR>
noremap <Leader>rh :call LanguageClient_textDocument_hover()<CR>

" Quit, Write, Exit
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Only window
nnoremap <Leader>o :only<CR>
