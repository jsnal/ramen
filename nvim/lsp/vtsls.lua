local function get_vue_ts_plugin()
    if vim.g._vue_ts_plugin then
        return vim.g._vue_ts_plugin
    end

    vim.g._vue_ts_plugin = vim.fn.exepath("vue-language-server"):gsub(
        "/bin/vue%-language%-server$",
        "/lib/language-tools/packages/language-server"
    )
    return vim.g._vue_ts_plugin
end

return {
    cmd = { 'vtsls', '--stdio' },
    init_options = {
        hostInfo = 'neovim',
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
    },
    root_markers = {
        'package-lock.json',
        'yarn.lock',
        'pnpm-lock.yaml',
        '.git',
    },
    on_init = function(client)
        local vue_ts_plugin = get_vue_ts_plugin()
        if not vue_ts_plugin then
            return
        end

        client.config.settings = client.config.settings or {}
        client.config.settings.vtsls = client.config.settings.vtsls or {}
        client.config.settings.vtsls.tsserver = client.config.settings.vtsls.tsserver or {}
        client.config.settings.vtsls.tsserver.globalPlugins = {
            {
                name = '@vue/typescript-plugin',
                location = vue_ts_plugin,
                languages = { 'vue' },
                configNamespace = 'typescript',
            },
        }
        client:notify('workspace/didChangeConfiguration', {
            settings = client.config.settings,
        })
    end,
}
