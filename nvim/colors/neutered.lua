-- Neutered colorscheme

vim.cmd.hi('clear')
if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'neutered'

local p = {
    bg = '#000000',
    ['bg+1'] = '#222222',
    ['bg+2'] = '#333333',
    ['fg-1'] = '#ADA797',
    fg = '#F8EFD8',
    blue = '#ACA7CB',
    ['blue+1'] = '#0000CD',
    cyan = '#D8F8EF',
    red = '#FF2400',
    green = '#2F822F',
    ['green+1'] = '#73D936',
    ['yellow-1'] = '#FFBF00',
    yellow = '#FFDD33',
    brown = '#CC8C3C',
}

local groups = {
    -- Base UI
    Normal = { fg = p['fg'], bg = p['bg'] },
    NormalNC = { link = 'Normal' },
    Conceal = {},
    Ignore = {},
    NonText = { fg = p['fg-1'] },
    Whitespace = { link = 'NonText' },
    SpecialKey = { link = 'NonText' },
    EndOfBuffer = { fg = p['fg-1'] },

    -- Cursor
    Cursor = {},
    lCursor = { link = 'Cursor' },
    CursorIM = { link = 'Cursor' },
    TermCursor = { link = 'Cursor' },
    TermCursorNC = { link = 'Cursor' },
    CursorLine = { link = 'ColorColumn' },
    CursorColumn = { link = 'ColorColumn' },
    CursorLineNr = { fg = p['fg-1'], bg = p['bg+1'], bold = true },
    MatchParen = { underline = true },

    -- Separators
    LineNr = { fg = p['fg-1'] },
    SignColumn = { link = 'LineNr' },
    FoldColumn = { link = 'SignColumn' },
    ColorColumn = { bg = p['bg+1'] },
    Folded = { fg = p['fg-1'], bg = p['bg+1'] },
    VertSplit = { fg = p['fg-1'], bg = p['fg-1'] },
    WinSeparator = { link = 'VertSplit' },

    -- Statusline, tabline, and winbar
    StatusLine = { fg = p['bg'], bg = p['fg'] },
    StatusLineNC = { fg = p['bg+2'], bg = p['fg-1'] },
    MsgSeparator = { link = 'StatusLine' },
    TabLine = { fg = p['fg'], bg = p['bg+1'] },
    TabLineFill = { link = 'TabLine' },
    TabLineSel = { fg = p['fg'], bg = p['bg'] },
    WinBar = { fg = p['fg'], bg = p['bg+1'], bold = true },
    WinBarNC = { link = 'WinBar' },

    -- Messages and command feedback
    ModeMsg = { fg = p['fg'], bold = true },
    MsgArea = { link = 'Normal' },
    MoreMsg = { link = 'ModeMsg' },
    Question = { link = 'ModeMsg' },
    OkMsg = { fg = p['fg'], bg = p['green'] },
    ErrorMsg = { fg = p['fg'], bg = p['red'] },
    WarningMsg = { fg = p['bg'], bg = p['yellow'] },
    Directory = { fg = p['blue'], bold = true },
    Title = { fg = p['fg'], bold = true },

    -- Floating windows
    NormalFloat = { bg = p['bg+2'] },
    FloatBorder = { link = 'NormalFloat' },
    FloatTitle = { fg = p['fg'], bg = p['bg+2'], bold = true },
    FloatFooter = { link = 'FloatTitle' },

    -- Menus and pickers
    WildMenu = { fg = p['fg'], bg = p['blue+1'] },
    QuickFixLine  = { link = 'WildMenu' },
    Pmenu = { bg = p['bg+2'] },
    PmenuSel = { fg = p['fg'], bg = p['blue+1'] },
    PmenuSbar = { bg = p['bg+1'] },
    PmenuThumb = { bg = p['fg'] },

    -- Search
    Search = { fg = p['fg'], bg = p['green'] },
    IncSearch = { fg = p['bg'], bg = p['yellow'] },
    CurSearch = { link = 'IncSearch' },

    -- Snippet tabstops
    SnippetTabstop = { link = 'Normal' },
    SnippetTabstopActive = { link = 'Normal' },

    -- Visual selection
    Visual = { fg = p['fg'], bg = p['blue+1'] },
    VisualNOS = { link = 'Visual' },

    -- Syntax: comments
    Comment = { fg = p['brown'] },
    SpecialComment = { link = 'Comment' },
    Todo = { fg = p['brown'], bold = true },

    -- Syntax: literals and identifiers
    Constant = { fg = p['fg'] },
    String = { fg = p['green+1'] },
    Character = { fg = p['green+1'] },
    Number = { fg = p['fg'] },
    Boolean = { fg = p['fg'] },
    Float = { fg = p['fg'] },
    Identifier = { fg = p['fg'] },
    Function = { fg = p['blue'] },

    -- Syntax: statements and keywords
    Statement = { fg = p['cyan'] },
    Conditional = { fg = p['cyan'] },
    Repeat = { fg = p['cyan'] },
    Label = { fg = p['cyan'] },
    Keyword = { fg = p['cyan'] },
    Exception = { fg = p['cyan'] },
    Operator = { fg = p['fg'] },

    -- Syntax: preprocessor and types
    PreProc = { fg = p['cyan'] },
    Include = { fg = p['cyan'] },
    Define = { fg = p['cyan'] },
    Macro = { fg = p['cyan'] },
    PreCondit = { fg = p['cyan'] },
    Type = { fg = p['cyan'] },
    StorageClass = { fg = p['cyan'] },
    Structure = { fg = p['cyan'] },
    Typedef = { fg = p['cyan'] },

    -- Syntax: special and formatting
    Special = { fg = p['cyan'] },
    SpecialChar = { fg = p['cyan'] },
    Tag = { fg = p['cyan'] },
    Delimiter = { fg = p['fg'] },
    Debug = { fg = p['fg'] },
    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Error = { bg = p['red'] },

    -- Diff
    Added = { fg = p['green+1'] },
    Changed = { fg = p['blue'] },
    Removed = { fg = p['red'] },
    DiffAdd = { fg = p['fg'], bg = p['green'] },
    DiffChange = { fg = p['bg'], bg = p['blue'] },
    DiffText = { fg = p['bg'], bg = p['cyan'] },
    DiffDelete = { fg = p['fg'], bg = p['red'] },

    -- Spelling
    SpellBad = { fg = p['red'] },
    SpellCap = { fg = p['cyan'] },
    SpellLocal = { fg = p['fg'] },
    SpellRare = { fg = p['cyan'] },

    -- Python
    pythonDocString = { link = 'Comment' },

    -- Diagnostics (LSP)
    DiagnosticError = { fg = p['red'] },
    DiagnosticWarn = { fg = p['yellow-1'] },
    DiagnosticInfo = { fg = p['blue'] },
    DiagnosticHint = { fg = p['cyan'] },
    DiagnosticOk = { fg = p['green+1'] },

    -- Treesitter
    ['@text'] = { link = 'Normal' },
    ['@texcolorscheme.literal'] = { link = 'Property' },
    ['@texcolorscheme.strong'] = { link = 'Bold' },
    ['@texcolorscheme.italic'] = { link = 'Italic' },
    ['@texcolorscheme.title'] = { link = 'Keyword' },
    ['@texcolorscheme.uri'] = { fg = p['blue'], sp = p['blue'], underline = true, },
    ['@texcolorscheme.underline'] = { link = 'Underlined' },
    ['@texcolorscheme.todo'] = { link = 'Todo' },
    ['@comment'] = { link = 'Comment' },
    ['@punctuation'] = { link = 'Punctuation' },
    ['@punctuation.bracket'] = { link = 'Normal' },
    ['@punctuation.terminator.statement'] = { link = 'Delimiter' },
    ['@constant'] = { link = 'Constant' },
    ['@constancolorscheme.builtin'] = { link = 'Keyword' },
    ["@define"] = { link = 'Define' },
    ["@macro"] = { link = 'Macro' },
    ['@string'] = { link = 'String' },
    ["@character"] = { link = 'Character' },
    ['@number'] = { link = 'Number' },
    ['@boolean'] = { link = 'Boolean' },
    ["@float"] = { link = 'Float' },
    ['@function'] = { link = 'Function' },
    ['@function.call'] = { link = 'Function' },
    ['@function.builtin'] = { link = 'Function' },
    ['@parameter'] = { link = 'Parameter' },
    ['@method'] = { fg = p['fg'] },
    ['@field'] = { link = 'Property' },
    ['@property'] = { link = 'Property' },
    ['@constructor'] = { link = 'Normal' },
    ['@label'] = { link = 'Label' },
    ['@operator'] = { link = 'Operator' },
    ['@exception'] = { link = 'Exception' },
    ['@variable'] = { link = 'Normal' },
    ['@variable.builtin'] = { link = 'Function' },
    ['@variable.member'] = { link = 'Normal' },
    ['@variable.parameter'] = { link = 'Normal' },
    ['@type'] = { link = 'Type' },
    ['@type.definition'] = { link = 'Type' },
    ['@type.builtin'] = { link = 'Function' },
    ['@type.qualifier'] = { link = 'Type' },
    ['@keyword'] = { link = 'Keyword' },
    ["@storageclass"] = { link = 'StorageClass' },
    ["@structure"] = { link = 'Structure' },
    ['@namespace'] = { link = 'Type' },
    ['@annotation'] = { link = 'Label' },
    ["@include"] = { link = 'Include' },
    ["@preproc"] = { link = 'PreProc' },
    ['@debug'] = { link = 'Special' },
    ['@tag'] = { link = 'Tag' },
    ['@tag.builtin'] = { link = 'Tag' },
    ['@error'] = { link = 'Error' },
    ['@warning'] = { link = 'WarningMsg' },
    ['@info'] = { fg = p['fg'], bg = p['blue'] },

    -- Semantic highlighting (LSP)
    ['@lsp.type.class'] = { link = 'Normal' },
    ['@lsp.type.comment'] = { link = 'Comment' },
    ['@lsp.type.decorator'] = { link = 'Statement' },
    ['@lsp.type.enum'] = { link = 'Type' },
    ['@lsp.type.enumMember'] = { link = 'Normal' },
    ['@lsp.type.event'] = { link = 'Type' },
    ['@lsp.type.function'] = { link = 'Function' },
    ['@lsp.type.interface'] = { link = 'Type' },
    ['@lsp.type.keyword'] = { link = 'Normal' },
    ['@lsp.type.macro'] = { link = 'Normal' },
    ['@lsp.type.method'] = { link = 'Normal' },
    ['@lsp.type.modifier'] = { link = 'Normal' },
    ['@lsp.type.namespace'] = { link = 'Normal' },
    ['@lsp.type.number'] = { link = 'Number' },
    ['@lsp.type.operator'] = { link = 'Operator' },
    ['@lsp.type.parameter'] = { link = 'Normal' },
    ['@lsp.type.property'] = { link = 'Normal' },
    ['@lsp.type.regexp'] = { link = 'String' },
    ['@lsp.type.string'] = { link = 'String' },
    ['@lsp.type.struct'] = { link = 'Type' },
    ['@lsp.type.type'] = { link = 'Type' },
    ['@lsp.type.typeParameter'] = { link = 'Type' },
    ['@lsp.type.variable'] = { link = 'Normal' },

    -- Diagnostics in statusline and gutter (LSP)
    DiagnosticSignError = { fg = p['bg'] },
    DiagnosticSignWarn = { fg = p['bg'] },
    DiagnosticSignInfo = { fg = p['bg'] },
    DiagnosticSignHint = { fg = p['bg'] },
    DiagnosticSignOk = { fg = p['bg'] },

    -- nvim-cmp
    ['CmpItemAbbr'] = { fg = p['fg'] },
    ['CmpItemAbbrDeprecated'] = { fg = p['fg'], strikethrough = true },
    ['CmpItemAbbrMatch'] = { fg = p['fg'] },
    ['CmpItemAbbrMatchFuzzy'] = { link = 'CmpItemAbbrMatch' },
    ['CmpItemKind'] = { fg = p['fg-1'] },
    ['CmpItemKindIcon'] = { link = 'CmpItemKind' },
    ['CmpItemMenu'] = { link = 'CmpItemKind' },

    -- oil.nvim
    OilEmpty = { link = 'NonText' },
    OilHidden = { link = 'NonText' },
    OilLinkTarget = { link = 'NonText' },
}

for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
end

-- Add 'pythonDocString' highlight group for docstrings. Note that this will
-- also pick up multi-line strings.
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        vim.schedule(function()
            vim.cmd.syntax([[region pythonDocString start=+[uU]\{,1}[rR]\{,1}"""+ end=+"""+ keepend contains=pythonSpaceError,@Spell]])
            vim.cmd.syntax([[region pythonDocString start=+[uU]\{,1}[rR]\{,1}'''+ end=+'''+ keepend contains=pythonSpaceError,@Spell]])
        end)
    end,
})
