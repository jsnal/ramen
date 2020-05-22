" Movement
noremap H ^
noremap L g_
noremap j gj
noremap k gk
noremap <C-y> <C-y><C-y><C-y>
noremap <C-e> <C-e><C-e><C-e>

" Very magic search
nnoremap +/ /\v
vnoremap +/ /\v
noremap <C-R> :%s/

" Leader
let mapleader = ","
noremap <Leader>c :TComment<CR>
noremap <Leader>l :nohlsearch<CR>
noremap <Leader>a :bprev<Return>
noremap <Leader>s :bnext<Return>
noremap <Leader>d :bd<Return>
noremap <Leader>f :b
noremap <Leader>rl :source %<CR>

" Git Mappings
noremap <Leader>gg :call ramen#buffer#switch('scratchpad')<CR>
noremap <Leader>gf :call ramen#buffer#scratchpad('git diff '. expand('%:p'))<CR>
noremap <Leader>gd :call ramen#buffer#scratchpad('git diff')<CR>
noremap <Leader>gs :call ramen#buffer#scratchpad('git status')<CR>

" TODO: Fix the error thrown when trying to switch from a git log buffer
noremap <Leader>gl :call ramen#buffer#scratchpad('git log -50')<CR>

" Function Mappings
noremap <F4> :setlocal foldmethod=marker<CR>
noremap <F6> mzgg=G`z`<CR>

" Move Lines in Visual Mode
xnoremap <silent> K :call ramen#visual#move_up()<CR>
xnoremap <silent> J :call ramen#visual#move_down()<CR>

" Check TODO List with date
nnoremap <F5> lix<Esc>ll"=strftime("%c")<CR>P

" Better split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Compile markdown on the fly
nnoremap <silent> <leader>p :execute '!~/ramen/zsh/scripts/vim_md ' . expand('%:p')<CR><CR>

" Move the cursor in wildmenu
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" Language Server
noremap <Leader>od :call LanguageClient_textDocument_definition()<CR>
