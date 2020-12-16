syntax on

set mouse=nv
set hidden
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

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

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

  " color preview
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
call plug#end()

" highlight error hints
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Gruvbox color scheme
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_matching_smart_case = 1

lua <<EOF
  require'lspconfig'.omnisharp.setup{on_attach=require'completion'.on_attach}
  require'lspconfig'.angularls.setup{on_attach=require'completion'.on_attach}
EOF

let g:fzf_layout = { 'window': {'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['right:70%:hidden', 'ctrl-/']
let $FZF_DEFAULT_OPTS='--reverse'

map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" color previews
let g:Hexokinase_highlighters = [ 'virtual' ]


let mapleader = " "

" Files
nnoremap <silent> <leader>ff :Files<CR>
" git files (git ls-files)
nnoremap <silent> <c-p> :GFiles<CR>
" edited files (git status)
nnoremap <silent> <leader>fF :GFiles?<CR>
" Search in local buffer [c]ommits
" nnoremap <silent> <leader>c :BCommits<CR>
" Search in all the project [C]ommits
" nnoremap <silent> <leader>C :Commits<CR>
" Search between open files - [b]uffers
nnoremap <silent> <leader>fb :Buffers<CR>
" Search in [l]ines on current buffer
nnoremap <silent> <leader>fl :BLines<CR>
" Search in all the opened buffers [L]ines
nnoremap <silent> <leader>fL :Lines<CR>
" Search in ultisnips [s]nippets
" nnoremap <silent> <leader>s :Snippets<CR>
" Search in [m]arks
nnoremap <silent> <leader>fm :Marks<CR>
" Edited files
nnoremap <silent> <leader>fh :History<CR>
" Search history
nnoremap <silent> <leader>f/ :History/<CR>
" Command history
nnoremap <silent> <leader>f: :History:<CR>
" Search in ag search
" nnoremap <silent> <leader>a :Ag
