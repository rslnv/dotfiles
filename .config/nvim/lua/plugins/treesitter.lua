local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

nvim_treesitter.setup({
	ensure_installed = { "help", "c_sharp", "javascript", "typescript", "css", "lua", "rust" },
	sync_install = false,
	auto_install = true,

	ignore_install = { "" }, -- List of parsers to ignore installing

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
})
