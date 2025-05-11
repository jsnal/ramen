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

if exists("g:serape_16bit")
    let s:black = { "gui": "#000000", "cterm": "0" }
    let s:dark_gray = { "gui": "#262626", "cterm": "8" }
    let s:gray = { "gui": "#8A8A8A", "cterm": "7" }
    let s:light_gray = { "gui": "#BFBFBF", "cterm": "7" }
    let s:red = { "gui": "#FF0000", "cterm": "9" }
    let s:light_green = { "gui": "#AFFF00", "cterm": "10" }
    let s:green = { "gui": "#008000", "cterm": "2" }
    let s:light_blue = { "gui": "#0087D7", "cterm": "6" }
    let s:blue = { "gui": "#0000FF", "cterm": "12" }
    let s:dark_blue = { "gui": "#005FD7", "cterm": "4" }
    let s:cyan = { "gui": "#5FD7FF", "cterm": "14" }
    let s:yellow = { "gui": "#FFFF00", "cterm": "11" }
    let s:orange = { "gui": "#FF5F00", "cterm": "3" }
    let s:dark_orange = { "gui": "#FFAF00", "cterm": "3" }
    let s:white = { "gui": "#FFFFFF", "cterm": "15" }
else
    let s:black = { "gui": "#000000", "cterm": "0" }
    let s:dark_gray = { "gui": "#262626", "cterm": "235" }
    let s:gray = { "gui": "#8A8A8A", "cterm": "245" }
    let s:light_gray = { "gui": "#BFBFBF", "cterm": "251" }
    let s:red = { "gui": "#FF0000", "cterm": "196" }
    let s:green = { "gui": "#008000", "cterm": "2" }
    let s:light_green = { "gui": "#AFFF00", "cterm": "154" }
    let s:light_blue = { "gui": "#0087D7", "cterm": "32" }
    let s:blue = { "gui": "#0000FF", "cterm": "12" }
    let s:dark_blue = { "gui": "#005FD7", "cterm": "26" }
    let s:cyan = { "gui": "#5FD7FF", "cterm": "38" }
    let s:yellow = { "gui": "#FFFF00", "cterm": "11" }
    let s:orange = { "gui": "#FF5F00", "cterm": "202" }
    let s:dark_orange = { "gui": "#FFAF00", "cterm": "214" }
    let s:white = { "gui": "#FFFFFF", "cterm": "15" }
endif

" Background and foreground
call s:h("Normal", { "bg": s:black, "fg": s:white })

" Cursor
call s:h("CursorColumn", { "bg": s:dark_gray })
call s:h("Cursor", { "fg": s:black, "bg": s:white })
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
call s:h("VertSplit", { "bg": s:white, "fg": s:white })
call s:h("TabLine", { "bg": s:white, "fg": s:black })
call s:h("TabLineFill", { "bg": s:white, "fg": s:black })
call s:h("TabLineSel", { "bg": s:dark_gray, "fg": s:white })

" Searching
call s:h("Search", { "bg": s:yellow, "fg": s:black })
call s:h("IncSearch", { "bg": s:yellow, "fg": s:black })

" Statusline
call s:h("StatusLine", { "bg": s:white, "fg": s:black })
call s:h("StatusLineNC", { "style": "reverse" })
call s:h("StatusLineTerm", { "bg": s:white, "fg": s:black })
call s:h("StatusLineTermNC", { "style": "reverse" })

" Menu
call s:h("WildMenu", { "bg": s:dark_gray, "fg": s:white, "style": "bold" })
call s:h("Question", { "fg": s:white, "style": "bold" })
call s:h("Title", { "fg": s:white, "style": "bold" })
call s:h("MoreMsg", { "fg": s:white, "style": "bold" })
call s:h("ModeMsg", { "fg": s:white })
call s:h("ErrorMsg", { "bg": s:red, "fg": s:white })
call s:h("WarningMsg", { "bg": s:yellow, "fg": s:black })

" Visual aid
call s:h("Directory", { "fg": s:cyan })
call s:h("MatchParen", { "bg": s:dark_gray })
call s:h("Visual", { "style": "reverse" })
call s:h("VisualNOS", { "style": "reverse" })
call s:h("NonText", { "fg": s:gray })
call s:h("Todo", { "fg": s:yellow })
call s:h("Underlined", { "fg": s:cyan, "style": "underline" })
call s:h("Error", { "bg": s:red, "fg": s:white })
call s:h("SpecialKey", { "bg": s:dark_gray, "fg": s:light_gray })

" Common language
call s:h("Comment", { "fg": s:gray })
call s:h("Constant", { "fg": s:light_blue })
call s:h("String", { "fg": s:light_blue })
call s:h("StringDelimiter", { "fg": s:dark_blue })
call s:h("Character", { "fg": s:light_blue })
call s:h("Boolean", { "fg": s:light_blue })
call s:h("Number", { "fg": s:cyan, "style": "bold" })
call s:h("Float", { "fg": s:cyan, "style": "bold" })
call s:h("Identifier", { "fg": s:white, "style": "bold" })
call s:h("Function", { "fg": s:blue })
call s:h("Statement", { "fg": s:orange, "style": "bold" })
call s:h("Conditional", { "fg": s:orange, "style": "bold" })
call s:h("Repeat", { "fg": s:orange, "style": "bold" })
call s:h("Label", { "fg": s:orange, "style": "bold" })
call s:h("Operator", { "fg": s:dark_orange })
call s:h("Keyword", { "fg": s:orange, "style": "bold" })
call s:h("Exception", { "fg": s:orange, "style": "bold" })

" C like
call s:h("PreProc", { "fg": s:red, "style": "bold" })
call s:h("Include", { "fg": s:red })
call s:h("Define", { "fg": s:red, "style": "bold" })
call s:h("Macro", { "fg": s:red, "style": "bold" })
call s:h("PreCondit", { "fg": s:red, "style": "bold" })

call s:h("Type", { "fg": s:light_green })
call s:h("StorageClas", { "fg": s:light_green })
call s:h("Structure", { "fg": s:light_green })
call s:h("Typedef", { "fg": s:light_green })

call s:h("Special", { "fg": s:dark_orange })
call s:h("SpecialChar", { "fg": s:dark_orange })
call s:h("Tag", { "fg": s:dark_orange })
call s:h("Delimiter", { "fg": s:dark_orange })
call s:h("SpecialComment", { "fg": s:gray })
call s:h("Debug", { "fg": s:dark_orange })

" Diff files and buffers
call s:h("DiffAdd", { "fg": s:white, "bg": s:green })
call s:h("DiffChange", { "fg": s:white, "bg": s:blue })
call s:h("DiffDelete", { "fg": s:white, "bg": s:red })
call s:h("DiffText", { "fg": s:black, "bg": s:yellow })
call s:h("DiffAdded", { "fg": s:white, "bg": s:green })
call s:h("DiffChanged", { "fg": s:white, "bg": s:blue })
call s:h("DiffRemoved", { "fg": s:white, "bg": s:red })
call s:h("DiffSubname", { "fg": s:black, "bg": s:yellow })
call s:h("DiffIndexLine", { "fg": s:black, "bg": s:yellow })

" Completion
call s:h("Pmenu", { "bg": s:dark_gray, "fg": s:white })
call s:h("PmenuSel", { "bg": s:white, "fg": s:black })
call s:h("PmenuSBar", { "bg": s:dark_gray, "fg": s:white })
call s:h("PmenuThumb", { "bg": s:white })

" Spelling
call s:h("SpellBad", { "fg": s:red })
call s:h("SpellCap", { "fg": s:cyan })
call s:h("SpellLocal", { "fg": s:red })
call s:h("SpellRare", { "fg": s:cyan, "style": "underline" })

" Git commit
call s:h("GitCommitSummary", { "fg": s:blue, "style": "bold" })
call s:h("GitCommitType", { "fg": s:white })

" HTML
call s:h("htmlTag", { "fg": s:cyan })
call s:h("htmlEndTag", { "fg": s:cyan })
call s:h("htmlTagName", { "fg": s:dark_orange })
call s:h("htmlTagN", { "fg": s:dark_orange })
call s:h("htmlEvent", { "fg": s:white })
call s:h("htmlSpecialChar", { "fg": s:green })

" Makefile
call s:h("makeTarget", { "fg": s:orange, "style": "bold" })
call s:h("makeSpecTarget", { "fg": s:yellow, "style": "bold" })

set background=dark

