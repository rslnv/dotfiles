return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		},
		opts = {
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					vertical = { width = 0.8 },
				},
			},
			-- pickers = {
			-- 	find_files = {
			-- 		theme = "ivy",
			-- 	},
			-- },
			extensions = {
				fzf = {},
			},
		},
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
