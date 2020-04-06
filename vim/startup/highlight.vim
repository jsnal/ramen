if has('syntax')
  " Statusline
  hi StatusLine       ctermfg=15   ctermbg=235  cterm=bold
  hi StatusLineNC     ctermfg=243  ctermbg=235  cterm=bold
  hi FileHeader       ctermfg=248  ctermbg=235  cterm=bold
  hi FileTail         ctermfg=15   ctermbg=235  cterm=bold
  hi ModeColor        ctermfg=15   ctermbg=243  cterm=bold
  hi ModeBlurColor    ctermfg=15   ctermbg=243  cterm=bold

  " Vertical Split
  hi VertSplit        ctermfg=235  ctermbg=235

  " Git Gutter
  hi GitGutterAdd     ctermfg=2    ctermbg=235
  hi GitGutterChange  ctermfg=3    ctermbg=235
  hi GitGutterDelete  ctermfg=1    ctermbg=235

  " Line Number
  hi CursorLine       ctermfg=none ctermbg=none cterm=none
  hi LineNr           ctermfg=245  ctermbg=235
  hi CursorLineNr     ctermfg=184  ctermbg=235  cterm=bold
endif
