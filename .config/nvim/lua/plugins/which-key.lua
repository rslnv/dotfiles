local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	print("which-key is not available")
	return
end

which_key.register({
	e = { "<cmd>NvimTreeToggle<CR>", "File tree" },
	b = {
		name = "Buffers",
		b = { "<cmd>bd<CR>", "Close current" },
		a = { "<cmd>bufdo bd<CR>", "Close all" },
		o = { ":%bd | e# | bd#<CR>", "Close other" },
		c = { "<cmd>BufferLinePickClose<CR>", "Close selected" },
		s = { "<cmd>BufferLinePick<CR>", "Select" },
		p = { "<cmd>BufferLineTogglePin<CR>", "Pin current" },
	},
	f = {
		name = "Find",
		f = { "<cmd>Telescope find_files<CR>", "Files" },
		g = { "<cmd>Telescope live_grep<CR>", "Text" },
		b = { "<cmd>Telescope buffers<CR>", "Buffers" },
		h = { "<cmd>Telescope help_hags<CR>", "Help" },
		c = { "<cmd>Telescope commands<CR>", "Commands" },
		C = { "<cmd>Telescope command_history<CR>", "Command history" },
	},
}, { prefix = "<leader>" })
