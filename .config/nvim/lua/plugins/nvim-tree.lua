local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	print("nvim-tree is not available")
	return
end

nvim_tree.setup({
	view = {
		adaptive_size = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
})
