local vue_ts_plugin = nil
local ok, npm_root = pcall(vim.fn.system, 'npm root -g')
if ok and npm_root ~= "" then
    vue_ts_plugin = npm_root:gsub("%s+$", "") .. '/@vue/language-server'
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
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vue_ts_plugin,
                        languages = { 'vue' },
                        configNamespace = 'typescript',
                    },
                },
            },
        },
    },
}
