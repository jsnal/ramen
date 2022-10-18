" Better inline fold text when the text is folded
function! ramen#fold#foldline() abort
  let numlines_folded = v:foldend - v:foldstart + 1
  let preamble = printf("[%d folded]", numlines_folded)
  return '+~~ ' . preamble . ' '
endfunction


" Set general fold options
function! ramen#fold#options() abort
  if has('folding')
    setlocal foldcolumn=0
    setlocal fillchars+=fold:~
    setlocal foldmethod=manual
    setlocal foldtext=ramen#fold#foldline()
  endif
endfunction


" Refresh the fold options when you load the view
function! ramen#fold#loadview() abort
  silent loadview
  silent call ramen#fold#options()
endfunction


" If you're not in the root directory cd into and mkview
function! ramen#fold#mkview() abort
  if exists('*haslocaldir') && haslocaldir()
    cd -
    mkview
    lcd -
  else
    mkview
  endif
endfunction
