if has('syntax')
  " Statusline
  hi StatusLine       ctermfg=15   ctermbg=235  cterm=bold
  hi StatusLineNC     ctermfg=243  ctermbg=234  cterm=bold
  hi FileHeader       ctermfg=248  ctermbg=235  cterm=bold
  hi FileTail         ctermfg=15   ctermbg=235  cterm=bold

  " Vertical Split
  hi VertSplit        ctermfg=235  ctermbg=235

  " Git Gutter
  hi GitGutterAdd     ctermfg=2    ctermbg=235
  hi GitGutterChange  ctermfg=3    ctermbg=235
  hi GitGutterDelete  ctermfg=1    ctermbg=235

  " Line Number
  hi CursorLine       ctermfg=none ctermbg=none cterm=none
  hi LineNr           ctermfg=245  ctermbg=none
  hi CursorLineNr     ctermfg=184  ctermbg=none cterm=bold

  " Language Client
  hi LanguageClientError   ctermfg=196 ctermbg=235 cterm=bold
  hi LanguageClientWarning ctermfg=11  ctermbg=235 cterm=bold
  hi LanguageClientInfo    ctermfg=12  ctermbg=235 cterm=bold
endif
