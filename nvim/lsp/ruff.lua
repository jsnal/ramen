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
    end,
}
