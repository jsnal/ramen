" " Folds
autocmd BufWinLeave *.* call fold#mkview()
autocmd BufWinEnter *.* call fold#loadview()

" Markdown, txt, LaTeX
autocmd BufReadPost,BufNewFile *.md,*.tex call functions#plaintext()

" delete whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" remove new line auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType netrw setl bufhidden=wipe

" close nerdtree if last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Override Default fzf statusline
autocmd! User FzfStatusLine call fzf#fzf_statusline()

" Remove highlighting on insert mode
autocmd InsertEnter * :let @/=""

" Enable coc.nvim when CursorHold is enabled, 500 Milliseconds
" TODO: Switch this over to LSP
" if vim_coc =~ 'true'
"   augroup load_coc
"     autocmd!
"     autocmd CursorHold * call plug#load('coc.nvim') | autocmd! load_coc
"   augroup END
" endif

" Set tabs to 4 spaces in python
autocmd Filetype *      set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd BufEnter *.py   set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" Set StatusLine
autocmd BufLeave,WinLeave * call statusline#blur()
autocmd BufEnter,WinEnter * call statusline#focus()
