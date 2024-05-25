return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("bufferline").setup({})
	end,
	keys = {
		--{ '<LEADER>bp', '<CMD>bprev<CR>', desc = '[B]uffer [P]rev' },
		--{ '<LEADER>bn', '<CMD>bnext<CR>', desc = '[B]uffer [N]ext' }
		{ "<S-h>", "<CMD>bprev<CR>", desc = "[B]uffer [P]rev" },
		{ "<S-l>", "<CMD>bnext<CR>", desc = "[B]uffer [N]ext" },
	},
}
