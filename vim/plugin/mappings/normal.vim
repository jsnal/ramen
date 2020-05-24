" Movement
noremap H ^
noremap L g_
noremap j gj
noremap k gk

" Scroll more lines at a time
noremap <C-y> <C-y><C-y><C-y>
noremap <C-e> <C-e><C-e><C-e>

" Very magic search
nnoremap +/ /\v

" Quick replacement
noremap <C-R> :%s/

" Better split navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Avoid unintentional switches to Ex mode
nnoremap Q <nop>

" Avoid unintentional help pages
nnoremap K <nop>
