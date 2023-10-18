-------------------------------------------------------------------------------
-- Globals {{{1 ---------------------------------------------------------------
-------------------------------------------------------------------------------
local home = vim.env.HOME
local config = home .. '/.config/nvim'
local root = vim.env.USER == 'root'

-------------------------------------------------------------------------------
-- Options {{{1 ---------------------------------------------------------------
-------------------------------------------------------------------------------
vim.opt.autoindent = true
vim.opt.backspace = 'indent,start,eol'
vim.opt.backup = false
vim.opt.backupcopy = 'yes'
vim.opt.backupdir = config .. '/back//.'
vim.opt.belloff = 'all'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.directory = config .. '/nvim/swap//.'
vim.opt.emoji = false
vim.opt.expandtab = true
vim.opt.fillchars = {
    diff = '.',
    eob = ' ',
    fold = '-',
}
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'indent'
vim.opt.formatoptions = 'j,n'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = {
    tab = '> ',
    trail = '•',
}
vim.opt.modelines = 5
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.shiftround = false
vim.opt.shiftwidth = 4
vim.opt.shortmess = 'AIOTWacot'
vim.opt.showbreak = '↳ '
vim.opt.showcmd = false
vim.opt.sidescroll = 0
vim.opt.sidescrolloff = 3
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.synmaxcol = 200
vim.opt.termguicolors = true
if root then
    vim.opt.undofile = false
else
    vim.opt.undodir = config .. '/undo//.'
    vim.opt.undofile = true
end
vim.opt.updatetime = 2000
vim.opt.updatecount = 0
vim.opt.viewdir = config .. '/view'
vim.opt.viewoptions = 'cursor,folds'
vim.opt.virtualedit = 'block'
vim.opt.visualbell = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
vim.opt.wrap = false
vim.opt.writebackup = false

vim.g.mapleader = ','

-- Prevent tcomment from making so many mappings
vim.g.tcomment_mapleader1 = ''
vim.g.tcomment_mapleader2 = ''
vim.g.tcomment_mapleader_comment_anyway = ''

-- Set colorscheme and detect the filetype
vim.cmd('colorscheme base16-bright')
vim.cmd('filetype indent plugin on')
vim.cmd('syntax on')

-------------------------------------------------------------------------------
-- Mappings {{{1 --------------------------------------------------------------
-------------------------------------------------------------------------------

-- Easier window split movement
vim.keymap.set('n', '<C-h>', '<C-w>h', {silent = true, noremap = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {silent = true, noremap = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {silent = true, noremap = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {silent = true, noremap = true})

-- Intuitive movement
vim.keymap.set({'n', 'v'}, 'H', '^', {silent = true, noremap = true})
vim.keymap.set({'n', 'v'}, 'L', 'g_', {silent = true, noremap = true})
vim.keymap.set({'n', 'v'}, 'j', 'gj', {silent = true, noremap = true})
vim.keymap.set({'n', 'v'}, 'k', 'gk', {silent = true, noremap = true})

-- Intuitive undo
vim.keymap.set('n', 'U', '<C-r>', {noremap = true})

-- Replace all
vim.keymap.set('n', '<C-r>', ':%s//g<Left><Left>', {silent = true, noremap = true})

-- Short cuts for saving and quiting
vim.keymap.set('n', '<Leader>q', ':q<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<Leader>w', ':w<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<Leader>x', ':x<CR>', {silent = true, noremap = true})

-- Find a file to edit
vim.keymap.set('n', '<C-f>', '<Plug>(PickerEdit)', {silent = true, noremap = true})

-- Quickly comment text
vim.keymap.set({'n', 'v'}, '<Leader>c', ':TComment<CR>', {silent = true, noremap = true})

-- Unmap quick help
vim.keymap.set('n', 'K', '<nop>', {silent = true, noremap = true})

-------------------------------------------------------------------------------
-- Plugins {{{1 ---------------------------------------------------------------
-------------------------------------------------------------------------------

-- Change directory into the project root
require('nvim-rooter').setup()

-- Completion engine
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }
}

-- LSP Config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

lspconfig.clangd.setup { capabilities = capabilities }
lspconfig.vuels.setup { capabilities = capabilities }

-------------------------------------------------------------------------------
-- Auto Commands {{{1 ---------------------------------------------------------
-------------------------------------------------------------------------------

-- Restore the cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})

-- Delete trailing whitespace
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = {"*"},
    callback = function()
        if vim.bo.filetype ~= "gitcommit" then
            return
        end
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end
})

-- Wrap and enable spell check for text files
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 0
        vim.opt_local.wrap = true
    end
})

-------------------------------------------------------------------------------
-- Visual {{{1 ----------------------------------------------------------------
-------------------------------------------------------------------------------

-- Statusline
vim.opt.statusline = '%f %r%m%h %= %{&filetype} %l/%L %c'

-- Highlight overrides
vim.api.nvim_set_hl(0, 'VertSplit', {fg='#505050', bold=true})
vim.api.nvim_set_hl(0, 'CursorLine', {fg='none', bg='none'})
vim.api.nvim_set_hl(0, 'CursorLineNr', {fg='#FFFF00', bold=true})

-- vim: foldmethod=marker
