" TODO: Fix the unicode error on linting
"
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_rootMarkers = {
      \   'javascript': ['tsconfig.json', '.flowconfig', 'package.json'],
      \   'typescript': ['tsconfig.json', '.flowconfig', 'package.json']
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
