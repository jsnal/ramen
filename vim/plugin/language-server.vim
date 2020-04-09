let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_rootMarkers = {
      \   'javascript': ['tsconfig.json', '.flowconfig', 'package.json'],
      \   'typescript': ['tsconfig.json', '.flowconfig', 'package.json']
      \ }

let g:LanguageClient_diagnosticsDisplay = {
        \ 1: {
        \ "signText": "X",
        \ "signTexthl": "ALEErrorSign",
        \ "virtualTexthl": "Error",
        \ },
        \ 2: {
        \ "signText": "W",
        \ "signTexthl": "ALEWarningSign",
        \ "virtualTexthl": "Todo",
        \ },
        \ 3: {
        \ "signText": "i",
        \ "signTexthl": "ALEInfoSign",
        \ "virtualTexthl": "Todo",
        \ },
        \ 4: {
        \ "signText": "h",
        \ "signTexthl": "ALEInfoSign",
        \ "virtualTexthl": "Todo",
        \ }
      \ }

let s:server_commands = {
      \   'javascript': 'javascript-typescript-stdio',
      \   'typescript': 'javascript-typescript-stdio',
      \ }

for [s:server_lang, s:server_command] in items(s:server_commands)
  if executable(s:server_command)
    let g:LanguageClient_serverCommands[s:server_lang] = [exepath(s:server_command)]
  endif
endfor
