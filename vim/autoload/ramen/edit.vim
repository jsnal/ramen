" Make editing easier by filling the known path to the current file
function! ramen#edit#start_edit(type) abort
  let s:path = expand('%:h')

  let s:trail = "/"

  if empty(s:path)
    let s:trail = ""
  endif

  call inputsave()
  let s:file = input(a:type . ": ", s:path . s:trail, "file")
  call inputrestore()

  execute a:type s:file
endfunction
