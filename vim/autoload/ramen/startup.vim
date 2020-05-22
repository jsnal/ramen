" Attempt to install vim-plug if it isn't already present. For this, we try to
" use both wget and curl and use the one that is found.
function! ramen#startup#plug() abort
  if !filereadable(expand('~/.vim/autoload/plug.vim'))
    echo 'Installing vim-plug'
    call system('mkdir -p ~/.vim/autoload/')
    let s:plug_source = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    let s:plug_destination = '~/.vim/autoload/plug.vim'

    if executable('curl')
      call system('curl "' . s:plug_source. '" > ' . s:plug_destination)
    elseif executable('wget')
      call system('wget -O ' . s:plug_destination. ' "' . s:plug_source . '"')
    else
      echo 'Unable to install vim-plug. Please install curl or wget.'
      echo 'Exiting...' | cquit
    endif
  endif
endfunction
