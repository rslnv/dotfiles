local o = vim.opt

-- install xsel under sway
o.clipboard = "unnamedplus" -- access system clipboard

o.completeopt = { "menu", "menuone", "noselect" }
o.mouse = "a"
o.hidden = true
o.smartcase = true
o.hlsearch = true

-- vim.bo.syntax = "on"
o.expandtab = true
o.smartindent = true
o.swapfile = false
o.backup = false
o.undodir = vim.fn.expand("~/.config/undodir")
o.undofile = true
o.termguicolors = true

o.splitbelow = true
o.splitright = true

o.numberwidth = 4
o.signcolumn = "yes"

o.showtabline = 2
o.cursorline = true
o.colorcolumn = "90"

o.relativenumber = true
o.number = true
o.wrap = false

local indent = 2
o.tabstop = indent
o.softtabstop = indent
o.shiftwidth = indent

local scrolloff = 8
o.scrolloff = scrolloff
o.sidescrolloff = scrolloff

-- global statusline
o.laststatus = 3

o.timeoutlen = 1000
