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
        {
            'stevearc/conform.nvim',
            version = nil,
            opts = {
                formatters_by_ft = {
                    python = { "ruff_format", "ruff_organize_imports" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            }
        },
        {
            'stevearc/oil.nvim',
            opts = {
                default_file_explorer = true,
                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                view_options = {
                    show_hidden = true,
                    natural_order = true,
                    sort = {
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                },
            },
            keys = {
                { "<C-x>d", function() require("oil").open() end, },
            }
        }
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
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
})
vim.lsp.enable({ 'basedpyright', 'clangd', 'ruff', 'vtsls', 'vue_ls' })
