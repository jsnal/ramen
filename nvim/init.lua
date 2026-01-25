-- Set options
vim.opt.autoindent = true
vim.opt.backspace = { 'indent', 'start', 'eol' }
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.expandtab = true
vim.opt.formatoptions = 'tcqjn'
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.joinspaces = false
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '> ' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.ruler = true
vim.opt.scrolloff = 3
vim.opt.shiftwidth = 4
vim.opt.shortmess = 'fixtmToO'
vim.opt.showcmd = false
vim.opt.signcolumn = 'no'
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.textwidth = 80
vim.opt.title = true
vim.opt.titlestring = '%t - nvim'
vim.opt.ttimeoutlen = 1
vim.opt.updatecount = 0
vim.opt.wildoptions = { 'tagfile' }
vim.opt.wildmode = { 'longest:list', 'full' }
vim.opt.wrap = false
vim.opt.writebackup = false

-- Set global leader key
vim.g.mapleader = ','

-- Set colorscheme
vim.cmd.colorscheme('neutered')

-- Setup extra configuration
pcall(require, 'ramen')

-- Intuitive movement
vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')

-- Saving and quitting
vim.keymap.set('n', '<Leader>q', ':q<CR>')
vim.keymap.set('n', '<Leader>w', ':w<CR>')

-- Quickly move lines up and down
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { silent = true })

-- Create config autocmd group
local autocmd_group = vim.api.nvim_create_augroup('Ramen', { clear = true })

-- Jump back to last known position on buffer open
vim.api.nvim_create_autocmd('BufReadPost', {
    group = autocmd_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Strip trailing whitespace on buffer write
vim.api.nvim_create_autocmd('BufWritePre', {
    group = autocmd_group,
    pattern = '*',
    callback = function()
        local exclude = { 'gitcommit', 'diff' }
        if not vim.tbl_contains(exclude, vim.bo.filetype) then
            vim.cmd([[%s/\s\+$//e]])
        end
    end,
})

-- Change settings for plaintext writing
vim.api.nvim_create_autocmd('FileType', {
    group = autocmd_group,
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.comments = 'b:*,b:-,b:+,n:>'
        vim.opt_local.conceallevel = 0
        vim.opt_local.formatoptions = 'tjnr'
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})

