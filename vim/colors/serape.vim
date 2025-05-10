" Serape Color Scheme
" File:     ~/.vim/colors/serape.vim
" Author:   Jason Long <jasonlongball@gmail.com>
" Version:  v0.3.0

if v:version > 600
    highlight clear
endif

if exists("syntax_on")
    syntax reset
endif

set background=dark
let g:colors_name = "serape"

function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg=" (has_key(a:style, "fg") ? a:style.fg.gui : "NONE")
    \ "guibg=" (has_key(a:style, "bg") ? a:style.bg.gui : "NONE")
    \ "guisp=" (has_key(a:style, "sp") ? a:style.sp.gui : "NONE")
    \ "gui=" (has_key(a:style, "style") ? a:style.style : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
    \ "cterm=" (has_key(a:style, "style") ? a:style.style : "NONE")
    \ "term=NONE"
endfunction

let s:black = { "gui": "#000000", "cterm": "0" }
let s:white = { "gui": "#FFFFFF", "cterm": "15" }

let s:dark_gray = { "gui": "#262626", "cterm": "235" }
let s:gray = { "gui": "#8A8A8A", "cterm": "245" }
let s:light_gray = { "gui": "#BFBFBF", "cterm": "251" }

let s:red = { "gui": "#FF0000", "cterm": "9" }
let s:cyan = { "gui": "#5FD7FF", "cterm": "38" }
let s:yellow = { "gui": "#FFFF00", "cterm": "11" }
let s:orange = { "gui": "#D75F5F", "cterm": "167" }
let s:green = { "gui": "#AFD75F", "cterm": "149" }

let s:bg = s:black
let s:fg = s:white

call s:h("Normal", { "bg": s:bg, "fg": s:fg })

" Cursor
call s:h("CursorColumn", { "bg": s:dark_gray })
call s:h("Cursor", { "bg": s:bg, "fg": s:fg })
call s:h("CursorLine", { "bg": s:dark_gray })
call s:h("CursorLineNR", { "fg": s:gray, "style": "bold" })
call s:h("QuickFixLine", { "bg": s:dark_gray })

" Column
call s:h("LineNR", { "fg": s:gray })
call s:h("Folded", { "bg": s:dark_gray, "fg": s:gray })
call s:h("FoldColumn", { "bg": s:dark_gray, "fg": s:gray })
call s:h("SignColumn", { "bg": s:dark_gray, "fg": s:gray })
call s:h("ColorColumn", { "bg": s:dark_gray })

" Window and Tab separators
call s:h("VertSplit", { "bg": s:light_gray, "fg": s:light_gray })
call s:h("TabLine", { "bg": s:light_gray, "fg": s:bg })
call s:h("TabLineFill", { "bg": s:light_gray, "fg": s:light_gray })
call s:h("TabLineSel", { "bg": s:white, "fg": s:bg })

" File Navigation / Searching
call s:h("Directory", { "fg": s:green })
call s:h("Search", { "bg": s:yellow, "fg": s:bg })
call s:h("IncSearch", { "bg": s:yellow, "fg": s:bg })

" Statusline
call s:h("Statusline", { "bg": s:light_gray, "fg": s:bg })
call s:h("StatuslineNC", { "bg": s:light_gray, "fg": s:bg })

" Menu
call s:h("WildMenu", { "bg": s:white, "fg": s:bg })
call s:h("Question", { "fg": s:fg, "style": "bold" })
call s:h("Title", { "fg": s:fg, "style": "bold" })
call s:h("MoreMsg", { "fg": s:fg, "style": "bold" })
call s:h("ModeMsg", { "fg": s:fg })
call s:h("ErrorMsg", { "bg": s:red, "fg": s:fg })
call s:h("WarningMsg", { "bg": s:yellow, "fg": s:bg })

" Visual aid
call s:h("MatchParen", { "bg": s:dark_gray })
call s:h("Visual", { "style": "reverse" })
call s:h("VisualNOS", { "style": "reverse" })
call s:h("NonText", { "fg": s:gray })

call s:h("Todo", { "fg": s:yellow })
call s:h("Underlined", { "fg": s:cyan, "style": "underline" })
call s:h("Error", { "bg": s:red, "fg": s:fg })
call s:h("SpecialKey", { "bg": s:dark_gray, "fg": s:light_gray })

" Variable type
hi Constant        ctermfg=32 guifg=#0087d7 ctermbg=NONE guibg=NONE
hi String          ctermfg=32 guifg=#0087d7 ctermbg=NONE guibg=NONE
hi StringDelimiter ctermfg=26 guifg=#005fd7 ctermbg=NONE guibg=NONE
hi Character       ctermfg=32 guifg=#0087d7 ctermbg=NONE guibg=NONE
hi Number          ctermfg=38 guifg=#00afd7 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Boolean         ctermfg=32 guifg=#0087d7 ctermbg=NONE guibg=NONE
hi Float           ctermfg=38 guifg=#00afd7 ctermbg=NONE guibg=NONE cterm=bold gui=bold

hi Identifier      ctermfg=15 guifg=#ffffff ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Function        ctermfg=12 guifg=#005fff ctermbg=NONE guibg=NONE

" Language construct
hi Statement       ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Conditional     ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Repeat          ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Operator        ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi Label           ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Keyword         ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Exception       ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Comment         ctermfg=244 guifg=#808080 ctermbg=NONE guibg=NONE

hi Special         ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi SpecialChar     ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi Tag             ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi Delimiter       ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi SpecialComment  ctermfg=244 guifg=#808080 ctermbg=NONE guibg=NONE
hi Debug           ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE

" C like
hi PreProc         ctermfg=196 guifg=#ff0000 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Include         ctermfg=196 guifg=#ff0000 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi Define          ctermfg=196 guifg=#ff0000 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi Macro           ctermfg=196 guifg=#ff0000 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi PreCondit       ctermfg=196 guifg=#ff0000 ctermbg=NONE guibg=NONE cterm=bold gui=bold

hi Type            ctermfg=154 guifg=#afff00 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi StorageClass    ctermfg=154 guifg=#afff00 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi Structure       ctermfg=154 guifg=#afff00 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi Typedef         ctermfg=154 guifg=#afff00 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE

" Diff
hi DiffAdd         ctermfg=15 guifg=#ffffff ctermbg=22   guibg=#005f00
hi DiffChange      ctermfg=15 guifg=#ffffff ctermbg=18   guibg=#000087
hi DiffDelete      ctermfg=88 guifg=#860000 ctermbg=88   guibg=#860000
hi DiffText        ctermfg=11 guifg=#ffff00 ctermbg=0    guibg=#000000 cterm=reverse gui=reverse
hi DiffFile        ctermfg=15 guifg=#ffffff ctermbg=NONE guibg=NONE    cterm=bold gui=bold

" Diff files (patches)
hi DiffAdded       ctermfg=10  guifg=#00ff00 ctermbg=NONE guibg=NONE
hi DiffChanged     ctermfg=18  guifg=#000087 ctermbg=NONE guibg=NONE
hi DiffRemoved     ctermfg=9   guifg=#ff0000 ctermbg=NONE guibg=NONE
hi DiffSubname     ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi DiffIndexLine   ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold

" Completion menu
call s:h("Pmenu", { "bg": s:dark_gray, "fg": s:fg })
call s:h("PmenuSel", { "bg": s:white, "fg": s:bg })
call s:h("PmenuSBar", { "bg": s:dark_gray, "fg": s:fg })
call s:h("PmenuThumb", { "bg": s:white })

" Spelling
hi SpellBad        ctermfg=9  guifg=#ff0000 ctermbg=NONE guibg=NONE
hi SpellCap        ctermfg=51 guifg=#00ffff ctermbg=NONE guibg=NONE
hi SpellLocal      ctermfg=9  guifg=#ff0000 ctermbg=NONE guibg=NONE
hi SpellRare       ctermfg=51 guifg=#00ffff ctermbg=NONE guibg=NONE

" Git Commit
hi GitCommitSummary ctermfg=12 guifg=#0000ff ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi GitCommitType    ctermfg=15 guifg=#ffffff ctermbg=NONE guibg=NONE

" HTML Tags
hi htmlTag         ctermfg=39  guifg=#00afff ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi htmlEndTag      ctermfg=39  guifg=#00afff ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi htmlTagName     ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi htmlTagN        ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE
hi htmlEvent       ctermfg=15  guifg=#ffffff ctermbg=NONE guibg=NONE
hi htmlSpecialChar ctermfg=77  guifg=#5fd787 ctermbg=NONE guibg=NONE

" Javascript
hi jsFuncName      ctermfg=134 guifg=#af5fd7 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi jsThis          ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE cterm=bold gui=bold

" CSS
hi cssClassName    ctermfg=134 guifg=#af5fd7 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi cssClassNameDot ctermfg=15  guifg=#ffffff ctermbg=NONE guibg=NONE
hi cssIdentifier   ctermfg=133 guifg=#af5faf ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi cssBraces       ctermfg=15  guifg=#ffffff ctermbg=NONE guibg=NONE cterm=bold gui=bold

" Python
hi pythonImport    ctermfg=196 guifg=#ff0000 ctermbg=NONE guibg=NONE cterm=NONE gui=NONE
hi pythonEscape    ctermfg=26  guifg=#005fd7 ctermbg=NONE guibg=NONE cterm=bold gui=bold

" Make
hi makeTarget      ctermfg=202 guifg=#ff5f00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi makeSpecTarget  ctermfg=11  guifg=#ffff00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi makeCommands    ctermfg=153 guifg=#afd7ff ctermbg=NONE guibg=NONE cterm=bold gui=bold

" NERD Tree
hi NERDTreeDir      ctermfg=214 guifg=#ffaf00 ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi NERDTreeDirSlash ctermfg=15  guifg=#ffffff ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi NERDTreeClosable ctermfg=15  guifg=#ffffff ctermbg=NONE guibg=NONE cterm=bold gui=bold
hi NERDTreeOpenable ctermfg=15  guifg=#ffffff ctermbg=NONE guibg=NONE cterm=bold gui=bold

" Terminal
hi StatusLineTerm   ctermfg=0 guifg=#000000 ctermbg=251 guibg=#bfbfbf cterm=NONE gui=NONE
hi StatusLineTermNC ctermfg=0 guifg=#000000 ctermbg=248 guibg=#a8a8a8 cterm=NONE gui=NONE
