function! ramen#edit#start_edit() abort
  let s:path = expand('%:p:h')

  :e s:path
endfunction
