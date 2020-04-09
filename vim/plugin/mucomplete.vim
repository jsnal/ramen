" TODO: See if I need to include this line
" let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
      \ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'],
      \ 'vim'     : ['path', 'cmd', 'keyn'],
      \ 'markdown': ['keyn', 'dict', 'uspl'],
      \ }

let g:mucomplete#can_complete = {
      \ 'default': {
      \    'omni': { t -> t =~# '\%(\.\)$' }
      \    }
      \  }
