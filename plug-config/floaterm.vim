let g:floaterm_keymap_toggle = '<F10>'
let g:floaterm_keymap_next   = '<F8>'
let g:floaterm_keymap_prev   = '<F9>'
let g:floaterm_keymap_new    = '<F7>'

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=0.8 --width=0.8'        , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                                             , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                                         , 'git'],
      \ 'n' : [':FloatermNew node'                                            , 'node'],
      \ 'p' : [':FloatermNew python'                                          , 'python'],
      \ 'r' : [':FloatermNew ranger'                                          , 'ranger'],
      \ 't' : [':FloatermToggle'                                              , 'toggle'],
      \ }
