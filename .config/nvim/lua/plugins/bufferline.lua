return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<S-h>", "<CMD>bprev<CR>", desc = "Buffer prev" },
		{ "<S-l>", "<CMD>bnext<CR>", desc = "Buffer next" },
		{ "<A-h>", "<CMD>BufferLineMovePrev<CR>", desc = "Buffer move left" },
		{ "<A-l>", "<CMD>BufferLineMoveNext<CR>", desc = "Buffer move right" },
	},
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diag)
				local ret = (diag.error and "󰅚 " .. diag.error .. " " or "")
					.. (diag.warning and "󰀪 " .. diag.warning or "")
				return vim.trim(ret)
			end,
		},
	},
}
