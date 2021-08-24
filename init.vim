call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
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
" Plug 'christoomey/vim-tmux-navigator'

let g:neoformat_enabled_cpp = ['clang-format']
let g:neoformat_enabled_cmake = ['cmake-format']

Plug 'liuchengxu/space-vim-dark'
Plug 'scrooloose/nerdcommenter'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-syntastic/syntastic'

" for flutter development
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'ryanoasis/vim-devicons'
call plug#end()

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

set background=dark
"set background=light
"let g:gruvbox_contrast_light="hard"
"let g:gruvbox_italic=1
"let g:gruvbox_invert_signs=0
"let g:gruvbox_improved_strings=0
"let g:gruvbox_improved_warnings=1
"let g:gruvbox_undercurl=1
"let g:gruvbox_contrast_dark="hard"
"colorscheme gruvbox

"set t_Co=256
colorscheme onedark

"let g:solarized_termcolors = 256
"colorscheme solarized

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_indent_guides_start_level = 2

"colorscheme gotham256
"let g:gotham_airline_emphasised_insert = 0

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

