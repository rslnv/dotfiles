return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},
	},
	config = function()
		require("which-key").add({
			{ "<leader>c", group = "Code" },
			{ "<leader>d", group = "Debugger" },
			{ "<leader>f", group = "Find" },
			{ "<leader>h", group = "Hunk" },
		})
	end,
}
