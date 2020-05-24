if has('folding')
  setlocal nofoldenable
endif

" Easily jump through hunks
nnoremap <buffer> <CR> /\v^(diff\|commit)<CR>z<CR>
