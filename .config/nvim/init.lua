vim.bo.syntax='on'

vim.o.mouse='nv'
vim.o.hidden=true

local indent=2
vim.bo.tabstop=indent
vim.bo.softtabstop=indent
vim.bo.shiftwidth=indent

vim.bo.expandtab=true
vim.bo.smartindent=true

vim.wo.relativenumber=true
vim.wo.number=true
vim.wo.wrap=false

vim.o.smartcase=true

vim.bo.swapfile=false
vim.o.backup=false
vim.o.undodir='~/.vim.undodir'
vim.bo.undofile=true
vim.o.termguicolors=true

vim.wo.colorcolumn='90'

vim.g.mapleader=' '
vim.g.completeopt='menu,menuone,noselect'




local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

local use = require('packer').use
require('packer').startup(function()
  use 'morhetz/gruvbox'
  use 'joshdick/onedark.vim' -- Theme inspired by Atom

  use 'tpope/vim-commentary'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'nvim-lua/completion-nvim'
  use 'tjdevries/nlua.nvim'
end)

vim.cmd [[colorscheme gruvbox]]



-- To get builtin LSP running, do something like:
-- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   on_attach = on_attach,

--   -- Include globals you want to tell the LSP are real :)
--   globals = {
--     -- Colorbuddy
--     "Color", "c", "Group", "g", "s",
--   }
-- })
