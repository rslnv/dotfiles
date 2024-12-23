return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	enabled = false,
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			-- javascriptreact = {"eslint_d"},
			-- typescriptreact = {"eslint_d"},
		}

		vim.keymap.set("n", "<leader>cl", function()
			lint.try_lint()
		end, { desc = "Lint current file" })
	end,
}
