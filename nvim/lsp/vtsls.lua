local function get_vue_ts_plugin()
    if vim.g._vue_ts_plugin then
        return vim.g._vue_ts_plugin
    end

    local npm_root = vim.fn.system('npm root -g')
    if npm_root ~= '' then
        vim.g._vue_ts_plugin = npm_root:gsub('%s+$', '') .. '/@vue/language-server'
        return vim.g._vue_ts_plugin
    end
end

return {
    cmd = { 'vtsls', '--stdio' },
    init_options = {
        hostInfo = 'neovim',
    },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
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
