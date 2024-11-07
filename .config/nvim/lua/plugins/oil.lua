return {
	"stevearc/oil.nvim",
	lazy = false,
	opts = {
		win_options = {
			winbar = "%!v:lua.get_oil_winbar()",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
	},
}
