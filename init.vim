call plug#begin('~/.config/nvim/plugged')

"Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
"Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'plasticboy/vim-markdown'
Plug 'altercation/vim-colors-solarized'
Plug 'ChaiScript/vim-chaiscript'
Plug 'ChaiScript/vim-cpp'
Plug 'Mizuchi/STL-Syntax'
Plug 'kien/rainbow_parentheses.vim'
Plug 'arecarn/crunch.vim'
Plug 'pboettch/vim-cmake-syntax'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'sjl/gundo.vim'
Plug 'spolu/dwm.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'sbdchd/neoformat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-syntastic/syntastic'
Plug 'xolox/vim-misc'
Plug 'whatyouhide/vim-gotham'
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/a.vim'
Plug 'whatyouhide/vim-gotham'

Plug 'liuchengxu/space-vim-dark'
Plug 'scrooloose/nerdcommenter'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-syntastic/syntastic'

" for flutter development
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'ryanoasis/vim-devicons'

Plug 'sainnhe/everforest'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'puremourning/vimspector'
Plug 'ray-x/lsp_signature.nvim'
Plug 'neovim/nvim-lspconfig'

call plug#end()
set switchbuf=usetab
syntax on
set hidden
set noerrorbells
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set incsearch
set colorcolumn=80
set nobackup
set backupdir=~/nvimbkpdir
highlight ColorColumn ctermbg=0 guibg=lightgrey
set title
set showcmd
set autoindent
set smartindent
set clipboard+=unnamedplus

let g:doxygen_enhanced_color=1
let g:load_doxygen_syntax=1

let g:tagbar_width=60
let g:tagbar_show_data_type=1
let g:tagbar_show_linenumbers=2
let g:tagbar_position='botright vertical'

let g:neoformat_enabled_cpp = ['clang-format']
let g:neoformat_enabled_cmake = ['cmake-format']

set expandtab
set shiftwidth=2
set lcs=trail:·,tab:»·
set list
set cursorline
set number
set undofile
set spell spelllang=en_us
set spellcapcheck=""
set signcolumn=yes
set relativenumber
set mouse=a
"let g:ycm_confirm_extra_conf = 0
let g:airline_powerline_fonts=1
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

"set background=dark
"set background=light
"let g:gruvbox_contrast_light="hard"
"let g:gruvbox_italic=1
"let g:gruvbox_invert_signs=0
"let g:gruvbox_improved_strings=0
"let g:gruvbox_improved_warnings=1
"let g:gruvbox_undercurl=1
"let g:gruvbox_contrast_dark="hard"
"colorscheme gruvbox

colorscheme everforest
let g:everforest_ui_contrast = 'high'
let g:everforest_background='hard'
let g:everforest_enable_italic=1


let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_indent_guides_start_level = 2

set laststatus=2
set termguicolors

autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

au VimEnter * RainbowParenthesesActivate
" Round disabled for CMakeLists.txt support...
"au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" au Syntax * RainbowParenthesesLoadChevrons

set backup

" key mapping for cpp compilation
nnoremap <F1> :!./a.out
nnoremap <F2> :!cat output.txt
nnoremap <F3> :TagbarToggle<CR>
nnoremap <F5> :!g++ % -Wall -Werror -std=c++17 -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=vla-bound -fsanitize=return -fsanitize=bounds -g<Enter>
map <F6> :NERDTreeToggle<CR>
map <F7> gg=G<C-o><C-o>
"nnoremap <F5> :!g++ -o %:r.out % -std=c++17<Enter>
"nnoremap <F1> :!./%:r.out

" eggcache vim
nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

lua <<EOF

require'lspconfig'.clangd.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.cmake.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.dartls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.java_language_server.setup{}
require'lspconfig'.kotlin_language_server.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '+', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  use_internal_diff = true,  -- If vim.diff or luajit is present
  yadm = {
    enable = false
  },
}
EOF


source $HOME/.config/nvim/keys/which-key.vim
source $HOME/.config/nvim/plug-config/floaterm.vim
