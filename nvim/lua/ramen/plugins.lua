-- Add all plugins
vim.pack.add({
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/stevearc/conform.nvim',
    'https://github.com/stevearc/oil.nvim',
})

-- Setup completion
local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1
            if cmp.visible() then
                cmp.select_next_item({ behavior = 'select' })
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    }),
    window = {
        documentation = cmp.config.disable
    },
})

-- Setup file explorer
require('oil').setup({
    default_file_explorer = true,
    columns = {
        'icon',
        'permissions',
        'size',
        'mtime',
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
        show_hidden = true,
        natural_order = true,
        sort = {
            { 'type', 'asc' },
            { 'name', 'asc' },
        },
    },
})
vim.keymap.set('n', '<C-x>d', '<CMD>Oil<CR>')

-- Setup file formatter
require('conform').setup({
    formatters_by_ft = {
        python = { 'ruff_format', 'ruff_organize_imports' },
        vue = { 'prettier' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
    },
    format_after_save = {
        async = true,
        timeout_ms = 1000,
        lsp_format = 'fallback',
    },
})

-- Setup LSP
vim.diagnostic.config({
    severity_sort = true,
    underline = false,
    update_in_insert = false,
    virtual_text = true,
    virtual_lines = false,
})
vim.lsp.enable({ 'basedpyright', 'clangd', 'ruff', 'vtsls', 'vue_ls' })
