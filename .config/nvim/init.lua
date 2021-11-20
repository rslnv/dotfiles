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
