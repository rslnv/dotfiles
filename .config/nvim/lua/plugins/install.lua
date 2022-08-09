local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	--vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost install.lua source <afile> | PackerCompile
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("packer is not available")
	return
end

return packer.startup({
	function(use)
		use("wbthomason/packer.nvim")

		use("nvim-lua/popup.nvim")
		use("nvim-lua/plenary.nvim")

		use("nvim-telescope/telescope.nvim")
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		use("windwp/nvim-autopairs")

		-- use "morhetz/gruvbox"
		use("sainnhe/gruvbox-material")

		use("numToStr/Comment.nvim")

		use("akinsho/toggleterm.nvim")

		use("akinsho/bufferline.nvim")
		use("nvim-lualine/lualine.nvim")

		use("kyazdani42/nvim-web-devicons")
		use("kyazdani42/nvim-tree.lua")

		-- cmp
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-nvim-lsp")
		use("saadparwaiz1/cmp_luasnip")

		use("L3MON4D3/LuaSnip")

		-- lsp
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use("jose-elias-alvarez/null-ls.nvim")

		use("nvim-lua/completion-nvim")
		use("tjdevries/nlua.nvim")

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})

		use("folke/which-key.nvim")

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if Packer_bootstrap then
			require("packer").sync()
		end
	end,

	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
