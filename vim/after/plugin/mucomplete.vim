let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
      \ 'default'  : ['path', 'omni', 'keyn', 'dict', 'uspl'],
      \ 'vim'      : ['path', 'cmd', 'keyn'],
      \ 'markdown' : ['keyn', 'dict', 'uspl', 'path'],
      \ 'gitcommit': ['keyn', 'dict', 'uspl', 'path'],
      \ }

let g:mucomplete#can_complete = {
      \ 'default': {
      \    'omni': { t -> t =~# '\%(\.\)$' }
      \    }
      \  }

if has('timers')
  let g:mucomplete#completion_delay = 50
  let g:mucomplete#reopen_immediately = 0
endif
