" Configuration for: https://github.com/yegappan/lsp

if !has('vim9script') ||  v:version < 900
    finish
endif

vim9script

if exists("g:loaded_lsp")
    autocmd User LspAttached
                \ set autocomplete |
                \ set complete=.,o,w,b,u

    g:LspOptionsSet({
        noNewlineInCompletion: v:true,
        autoHighlightDiags: v:true,
        completionMatcher: "fuzzy",
        diagSignErrorText: 'E:',
        diagSignHintText: 'H:',
        diagSignInfoText: 'I:',
        diagSignWarningText: 'W:',
        diagVirtualTextAlign: "after",
        highlightDiagInline: v:false,
        showDiagWithVirtualText: v:true,
        showInlayHints: v:false,
    })

    if executable("clangd")
        g:LspAddServer([{
            name: "clangd",
            filetype: ["c", "cpp"],
            path: exepath("clangd"),
            args: ["--background-index"]
        }])
    endif

    if executable("pyright-langserver")
        g:LspAddServer([{
            name: "pyright",
            filetype: ["python"],
            path: exepath("pyright-langserver"),
            args: ["--stdio"],
            workspaceConfig: {
                python: {
                    pythonPath: exepath("python3")
                }
            }
        }])
    endif
endif
