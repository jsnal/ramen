return {
    cmd = { 'vue-language-server', '--stdio' },
    filetypes = { 'vue' },
    root_markers = { 'package.json' },
    init_options = {
        typescript = {
            tsdk = '/home/jason/Projects/Waveform/frontend/node_modules/typescript/lib'
        },
    },
    on_init = function(client)
        client.handlers['tsserver/request'] = function(_, result, context)
            local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })

            if #clients == 0 then
                vim.notify('Cannot find vtsls', vim.log.levels.ERROR)
                return
            end
            local ts_client = clients[1]

            local param = unpack(result)
            local id, command, payload = unpack(param)
            ts_client:exec_cmd({
                title = 'vue_request_forward',
                command = 'typescript.tsserverRequest',
                arguments = {
                    command,
                    payload,
                },
            }, { bufnr = context.bufnr }, function(_, r)
                local response_data = { { id, r and r.body } }
                client:notify('tsserver/response', response_data)
            end)
        end
    end,
}
