return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					-- 'stylua',
					"omnisharp",
					"angularls",
					-- "eslint_d",
					-- 'prettierd'
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
			})
			-- lspconfig.csharp_ls.setup({ capabilities = capabilities })

			local angular_path = "/usr/lib/node_modules/"
			-- local angular_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules"
			local angular_cmd = {
				"ngserver",
				"--stdio",
				"--tsProbeLocations",
				angular_path,
				"--ngProbeLocations",
				angular_path,
			}

			lspconfig.angularls.setup({
				cmd = angular_cmd,
				on_new_config = function(new_config, new_root_dir)
					new_config.cmd = angular_cmd
				end,
			})
      -- lspconfig.angularls.setup({})

			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
			-- vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
		end,
	},
}
