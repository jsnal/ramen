-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require('lazy').setup({
    spec = {
        {
            'miikanissi/modus-themes.nvim',
            version = nil,
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd([[colorscheme modus_vivendi]])
            end,
        },
        {
            'hrsh7th/nvim-cmp',
            version = nil,
            dependencies = {
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-path',
            },
            opts = function()
                local cmp = require('cmp')
                cmp.setup({
                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'path' },
                    },
                    mapping = cmp.mapping.preset.insert({
                        ['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                        ['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),
                        ['<CR>'] = cmp.mapping.confirm({select = false}),
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            local col = vim.fn.col('.') - 1
                            if cmp.visible() then
                                cmp.select_next_item({behavior = 'select'})
                            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                                fallback()
                            else
                                cmp.complete()
                            end
                        end, {'i', 's'}),
                        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                    }),
                    window = {
                        documentation = cmp.config.disable
                    },
                })
            end
        },
        { 'tpope/vim-rsi', version = nil }
    },
    checker = { enabled = true },
})

-- Setup LSP
vim.diagnostic.config({
    severity_sort = true,
    underline = false,
    update_in_insert = false,
    virtual_text = true,
    virtual_lines = false,
})
vim.lsp.enable({ 'basedpyright', 'clangd', 'ruff' })
