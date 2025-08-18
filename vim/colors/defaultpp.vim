" Default++ Vim Color Scheme
" Maintainer:  Jason Long <jasonlongball@gmail.com>
" Last Change: 2025 Jul 07

set background=dark

if v:version > 600
    highlight clear
endif

if exists("syntax_on")
    syntax reset
endif

let colors_name = "defaultpp"

hi! link ColorColumn StatusLine

hi Visual ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE term=reverse cterm=reverse gui=reverse
hi VisualNOS ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE term=reverse cterm=reverse gui=reverse

hi DiffAdd ctermfg=White ctermbg=DarkGreen guifg=White guibg=DarkGreen term=NONE cterm=NONE gui=NONE
hi DiffDelete ctermfg=White ctermbg=DarkRed guifg=White guibg=DarkRed term=NONE cterm=NONE gui=NONE
hi DiffChange ctermfg=White ctermbg=DarkBlue guifg=White guibg=DarkBlue term=NONE cterm=NONE gui=NONE
hi DiffText ctermfg=Black ctermbg=Yellow guifg=Black guibg=Yellow term=NONE cterm=NONE gui=NONE

hi Pmenu ctermfg=Black ctermbg=White guifg=Black guibg=White term=NONE cterm=NONE gui=NONE
hi PmenuSel ctermfg=Black ctermbg=White guifg=Black guibg=White term=reverse cterm=reverse gui=reverse
hi PmenuSBar ctermfg=NONE ctermbg=Gray guifg=NONE guibg=Gray term=NONE cterm=NONE gui=NONE
hi PmenuThumb ctermfg=NONE ctermbg=Black guifg=NONE guibg=Black term=NONE cterm=NONE gui=NONE

hi SpellBad ctermfg=Black ctermbg=Red guifg=Black guibg=Red term=NONE cterm=NONE gui=NONE
hi SpellCap ctermfg=Black ctermbg=Cyan guifg=NONE guibg=Black term=NONE cterm=NONE gui=NONE
hi SpellLocal ctermfg=Black ctermbg=Cyan guifg=Black guibg=Cyan term=NONE cterm=NONE gui=NONE
hi SpellRare ctermfg=Black ctermbg=Red guifg=Black guibg=Red term=NONE cterm=NONE gui=NONE
