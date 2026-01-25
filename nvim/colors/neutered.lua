-- Neutered colorscheme

vim.cmd.hi('clear')
if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
end

vim.opt.termguicolors = true
vim.g.colors_name = 'neutered'

local p = {
    bg = '#202020',
    ['bg+1'] = '#303030',
    ['bg+2'] = '#404040',
    ['fg-2'] = '#948f81',
    ['fg-1'] = '#F0DDAD',
    fg = '#F8EFD8',
    blue = '#ACA7CB',
    cyan = '#D8F8EF',
    red = '#FF2400',
    green = '#2F822F',
    ['green+1'] = '#73D936',
    ['yellow-1'] = '#FFBF00',
    yellow = '#FFDD33',
}

local groups = {
    -- Base UI
    Normal = { fg = p['fg'], bg = p['bg'] },
    NormalNC = { link = 'Normal' },
    Conceal = {},
    Ignore = {},
    NonText = { fg = p['fg-2'] },
    Whitespace = { link = 'NonText' },
    SpecialKey = { link = 'NonText' },
    EndOfBuffer = { fg = p['fg-2'] },

    -- Cursor
    Cursor = {},
    lCursor = { link = 'Cursor' },
    CursorIM = { link = 'Cursor' },
    TermCursor = { link = 'Cursor' },
    TermCursorNC = { link = 'Cursor' },
    CursorLine = { link = 'ColorColumn' },
    CursorColumn = { link = 'ColorColumn' },
    CursorLineNr = { fg = p['fg-2'], bg = p['bg+1'], bold = true },
    MatchParen = { bg = p['fg-2'] },

    -- Separators
    LineNr = { fg = p['fg-2'] },
    SignColumn = { link = 'LineNr' },
    FoldColumn = { link = 'SignColumn' },
    ColorColumn = { bg = p['bg+1'] },
    Folded = { fg = p['fg-2'], bg = p['bg+1'] },
    VertSplit = { fg = p['fg-1'], bg = p['fg-1'] },
    WinSeparator = { link = 'VertSplit' },

    -- Statusline, tabline, and winbar
    StatusLine = { fg = p['bg'], bg = p['fg-1'] },
    StatusLineNC = { fg = p['bg+2'], bg = p['fg-1'] },
    MsgSeparator = { link = 'StatusLine' },
    TabLine = { fg = p['fg'], bg = p['bg+1'] },
    TabLineFill = { link = 'TabLine' },
    TabLineSel = { fg = p['fg'], bg = p['bg'] },
    WinBar = { fg = p['fg'], bg = p['bg+1'], bold = true },
    WinBarNC = { link = 'WinBar' },

    -- Messages and command feedback
    ModeMsg = { fg = p['fg-1'], bold = true },
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
    WildMenu = { fg = p['bg'], bg = p['yellow-1'] },
    QuickFixLine  = { link = 'WildMenu' },
    Pmenu = { bg = p['bg+2'] },
    PmenuSel = { fg = p['bg'], bg = p['yellow-1'] },
    PmenuSbar = { bg = p['bg+1'] },
    PmenuThumb = { bg = p['fg'] },

    -- Search
    Search = { fg = p['fg'], bg = p['green'] },
    IncSearch = { fg = p['bg'], bg = p['yellow'] },
    CurSearch = { link = 'IncSearch' },
    Substitute = { fg = p['fg'], bg = p['red'] },

    -- Visual selection
    Visual = { fg = p['bg'], bg = p['yellow-1'] },
    VisualNOS = { link = 'Visual' },

    -- Syntax: comments
    Comment = { fg = p['fg-2'] },
    SpecialComment = { link = 'Comment' },
    Todo = { fg = p['fg-1'], bold = true },

    -- Syntax: literals and identifiers
    Constant = { fg = p['fg'] },
    String = { fg = p['green+1'] },
    Character = { fg = p['green+1'] },
    Number = { fg = p['fg'] },
    Boolean = { fg = p['yellow'], bold = true },
    Float = { fg = p['fg'] },
    Identifier = { fg = p['fg'] },
    Function = { fg = p['blue'] },

    -- Syntax: statements and keywords
    Statement = { fg = p['yellow'] },
    Conditional = { fg = p['yellow'], bold = true },
    Repeat = { fg = p['yellow'], bold = true },
    Label = { fg = p['yellow'], bold = true },
    Keyword = { fg = p['yellow'], bold = true },
    Exception = { fg = p['yellow'], bold = true },
    Operator = { fg = p['fg'] },

    -- Syntax: preprocessor and types
    PreProc = { fg = p['cyan'] },
    Include = { fg = p['cyan'] },
    Define = { fg = p['cyan'] },
    Macro = { fg = p['cyan'] },
    PreCondit = { fg = p['cyan'] },
    Type = { fg = p['cyan'] },
    StorageClass = { fg = p['yellow'], bold = true },
    Structure = { fg = p['yellow'], bold = true },
    Typedef = { fg = p['yellow'], bold = true },

    -- Syntax: special and formatting
    Special = { fg = p['yellow'] },
    SpecialChar = { fg = p['yellow'] },
    Tag = { fg = p['yellow'] },
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

    -- Diagnostics (LSP)
    DiagnosticError = { fg = p['red'] },
    DiagnosticWarn = { fg = p['yellow-1'] },
    DiagnosticInfo = { fg = p['blue'] },
    DiagnosticHint = { fg = p['blue'] },
    DiagnosticOk = { fg = p['green+1'] },

    -- Treesitter
    ['@text'] = { fg = p['fg'] },
    ['@texcolorscheme.literal'] = { link = 'Property' },
    ['@texcolorscheme.strong'] = { link = 'Bold' },
    ['@texcolorscheme.italic'] = { link = 'Italic' },
    ['@texcolorscheme.title'] = { link = 'Keyword' },
    ['@texcolorscheme.uri'] = { fg = p['blue'], sp = p['blue'], underline = true, },
    ['@texcolorscheme.underline'] = { link = 'Underlined' },
    ['@texcolorscheme.todo'] = { link = 'Todo' },
    ['@comment'] = { link = 'Comment' },
    ['@punctuation'] = { link = 'Punctuation' },
    ['@punctuation.bracket'] = { fg = p['fg'] },
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
    ['@constructor'] = { fg = p['fg'] },
    ['@label'] = { link = 'Label' },
    ['@operator'] = { link = 'Operator' },
    ['@exception'] = { link = 'Exception' },
    ['@variable'] = { fg = p['fg'] },
    ['@variable.builtin'] = { fg = p['blue'] },
    ['@variable.member'] = { fg = p['fg'] },
    ['@variable.parameter'] = { fg = p['fg'] },
    ['@type'] = { link = 'Type' },
    ['@type.definition'] = { link = 'Type' },
    ['@type.builtin'] = { fg = p['blue'] },
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
    ['@lsp.type.namespace'] = { link = '@namespace' },
    ['@lsp.type.type'] = { link = '@type' },
    ['@lsp.type.class'] = { link = '@type' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.interface'] = { link = '@type' },
    ['@lsp.type.struct'] = { link = '@type' },
    ['@lsp.type.parameter'] = { link = '@parameter' },
    ['@lsp.type.property'] = { link = '@text' },
    ['@lsp.type.function'] = { link = '@function' },
    ['@lsp.type.method'] = { link = '@method' },
    ['@lsp.type.macro'] = { link = '@label' },
    ['@lsp.type.decorator'] = { link = '@label' },
    ['@lsp.typemod.function.declaration'] = { link = '@function' },
    ['@lsp.typemod.function.readonly'] = { link = '@function' },
}

for group, parameters in pairs(groups) do
    vim.api.nvim_set_hl(0, group, parameters)
end

