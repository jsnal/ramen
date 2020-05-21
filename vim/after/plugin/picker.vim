" TODO: Make the windows return back to their sizes after the search
let g:picker_height = winheight(0) / 2

if executable('ag')
  let g:picker_custom_find_executable = 'ag'
  let g:picker_custom_find_flags = '--nocolor --files-with-matches'
endif

if executable('fzy')
  let g:picker_selector_flags = '--prompt ">> " --show-info --lines ' . g:picker_height
endif

" Handle searching through codebase using Ag
function! picker#aglinehandler(selection) abort
  let parts = split(a:selection, ':')
  return {'filename': parts[0], 'line': parts[1], 'column': parts[2]}
endfunction

command! -nargs=? PickerAg
      \ call picker#File('ag --vimgrep ' . shellescape(<q-args>), "edit", {'line_handler': 'picker#aglinehandler'})

" General Mappings
noremap <Leader>ag :PickerAg<Space>
nmap <unique> <Leader>ph <Plug>(PickerHelp)
nmap <unique> <Leader>pe <Plug>(PickerEdit)
nmap <unique> <Leader>px <Plug>(PickerSplit)
nmap <unique> <Leader>pv <Plug>(PickerVsplit)
