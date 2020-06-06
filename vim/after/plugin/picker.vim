let g:picker_height = string(&lines * 0.33)

if executable('fzy')
  let g:picker_selector_flags = '--prompt ">> " --show-info --lines ' . g:picker_height
endif

" General Mappings
nmap <unique> <Leader>ph <Plug>(PickerHelp)
nmap <unique> <Leader>pe <Plug>(PickerEdit)
nmap <unique> <Leader>px <Plug>(PickerSplit)
nmap <unique> <Leader>pv <Plug>(PickerVsplit)

" Set ripgrep specific bindings and overrides
if executable('rg')
  let g:picker_custom_find_executable = 'rg'
  let g:picker_custom_find_flags = '--files --color never'

  command! -nargs=? PickerRg
        \ call picker#File('rg --vimgrep ' . shellescape(<q-args>),
        \                  'edit',
        \                  {'line_handler': 'ramen#picker#rglinehandler'}
        \ )

  noremap <Leader>rg :PickerRg<Space>
endif

