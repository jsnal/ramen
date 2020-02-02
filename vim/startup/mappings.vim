noremap <TAB><TAB> :source %<CR>

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

" Function Keys
noremap <silent> <F2> :NERDTreeToggle<CR>
noremap <F4> :setlocal foldmethod=marker<CR>
noremap <F6> mzgg=G`z`<CR>

" FZF Bindings
noremap <C-f> :Files<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Move Lines in Visual Mode
xnoremap <silent> K :call visual#move_up()<CR>
xnoremap <silent> J :call visual#move_down()<CR>

" Check TODO List with date
nnoremap <F5> lix<Esc>ll"=strftime("%c")<CR>P

" Better split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Ag for word under cursor
nnoremap <silent> <leader>ag :Ag<CR>

" Compile markdown on the fly
nnoremap <silent> <leader>p :execute '!~/i3wm/zsh/scripts/vim_md ' . expand('%:p')<CR><CR>

" Move the cursor in wildmenu
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>
