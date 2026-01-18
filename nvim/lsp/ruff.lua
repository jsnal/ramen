return {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
    init_options = {
        settings = {
            lint = { enable = false },
        },
    },
    settings = {},
    on_attach = function(client, bufnr)
        if client.name ~= 'ruff' then
            return
        end

        -- Leave this to basedpyright
        client.server_capabilities.hoverProvider = false

        -- Auto-format on save
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.code_action({
                    context = { only = { 'source.organizeImports.ruff' } },
                    apply = true,
                })
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
            end,
        })
    end,
}
