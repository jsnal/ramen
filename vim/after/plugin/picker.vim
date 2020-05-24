" TODO: Set the statusline
let g:picker_height = string(&lines * 0.33)

if executable('ag')
  let g:picker_custom_find_executable = 'ag'
  let g:picker_custom_find_flags = '--nocolor --files-with-matches'
endif

if executable('fzy')
  let g:picker_selector_flags = '--prompt ">> " --show-info --lines ' . g:picker_height
endif

command! -nargs=? PickerAg
      \ call picker#File('ag --vimgrep ' . shellescape(<q-args>), "edit", {'line_handler': 'ramen#picker#aglinehandler'})

" General Mappings
noremap <Leader>ag :PickerAg<Space>
nmap <unique> <Leader>ph <Plug>(PickerHelp)
nmap <unique> <Leader>pe <Plug>(PickerEdit)
nmap <unique> <Leader>px <Plug>(PickerSplit)
nmap <unique> <Leader>pv <Plug>(PickerVsplit)
