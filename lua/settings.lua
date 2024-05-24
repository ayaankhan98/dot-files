vim.cmd([[
syntax on
set modifiable
set termguicolors
set cursorline
set number
set undofile
set signcolumn=yes
set clipboard+=unnamedplus
set colorcolumn=80
if has('clipboard')
  set clipboard=unnamedplus
endif

set mouse=a
set tabstop=1
set shiftwidth=1

colorscheme onedark 

let g:blamer_enabled = 1 

let g:floaterm_keymap_toggle = '<F10>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_new    = '<F7>'

set foldmethod=indent
set foldcolumn=1
set nofoldenable

nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa
]])


