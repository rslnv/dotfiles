return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			on_attach = function(bufnr)
				vim.keymap.set("n", "<leader>]h", gitsigns.next_hunk, { buffer = bufnr, desc = "Hunk next" })
				vim.keymap.set("n", "<leader>[h", gitsigns.prev_hunk, { buffer = bufnr, desc = "Hunk prev" })

				vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage" })
				vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset" })

				vim.keymap.set("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { buffer = bufnr, desc = "Stage" })
				vim.keymap.set("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { buffer = bufnr, desc = "Reset" })

				vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr, desc = "Undo staging" })

				vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr, desc = "Hunk preview" })

				vim.keymap.set(
					"n",
					"<leader>hB",
					gitsigns.toggle_current_line_blame,
					{ buffer = bufnr, desc = "Blame toggle" }
				)
				vim.keymap.set("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { buffer = bufnr, desc = "Blame" })

				vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
				vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })

				vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buffer = bufnr, desc = "Diff this" })
				vim.keymap.set("n", "<leader>hD", function()
					gitsigns.diffthis("~")
				end, { buffer = bufnr, desc = "Diff this ~" })

				-- Text object
				vim.keymap.set(
					{ "o", "x" },
					"ih",
					":<C-U>Gitsigns select_hunk<CR>",
					{ buffer = bufnr, desc = "Gitsigns select hunk" }
				)
			end,
		})
	end,
}
