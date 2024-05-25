return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({

			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "[H]unk [P]review" })
				vim.keymap.set(
					"n",
					"<leader>hb",
					gitsigns.toggle_current_line_blame,
					{ buffer = bufnr, desc = "[H]unk [B]lame toggle" }
				)
				vim.keymap.set("n", "<leader>hB", function()
					gitsigns.blame_line({ full = true })
				end, { buffer = bufnr, desc = "[H]unk [B]lame" })
			end,
		})
	end,
}
