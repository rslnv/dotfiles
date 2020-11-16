syntax on

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set relativenumber
set number
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set completeopt=menuone,noinsert,noselect

set colorcolumn=90

call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-commentary'

Plug 'preservim/nerdtree'

call plug#end()

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1

let g:completion_matching_strategy_list=['exact', 'substring', 'fuzzy']
lua require'nvim_lsp'.omnisharp.setup{ on_attach=require'completion'.on_attach }

let g:fzf_layout = { 'window': {'width': 0.8, 'height': 0.9 } }
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-/']

map <C-n> :NERDTreeToggle<CR>
