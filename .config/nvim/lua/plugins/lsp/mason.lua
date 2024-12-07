return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"omnisharp",
				-- "csharp_ls",
				"ts_ls",
				-- "tsserver",
				"angularls",
				"html",
				-- "cssls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"prettier",
				-- "prettierd",
				"eslint_d",
			},
		})
	end,
}
