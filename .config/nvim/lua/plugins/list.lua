return {
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"mbbill/undotree",
		event = "VeryLazy",
	},
}
