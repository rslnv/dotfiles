return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local util = require("lspconfig.util")

		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		mason_lspconfig.setup_handlers({
			-- Configuring with defaults
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
								disable = { "missing-fields" },
								globals = { "vim" },
							},
							workspace = {
								-- make language server aware of runtime files
								library = vim.api.nvim_get_runtime_file("", true),
								-- library = {
								-- 	[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								-- 	[vim.fn.stdpath("config") .. "/lua"] = true,
								-- },
							},
							telemetry = { enabled = false },
						},
					},
				})
			end,

			["omnisharp"] = function()
				lspconfig["omnisharp"].setup({
					capabilities = capabilities,
					cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
				})
			end,

			["angularls"] = function()
				local angular_path = "/usr/lib/node_modules/"
				-- local angular_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules/"
				local angular_cmd = {
					"ngserver",
					"--stdio",
					"--tsProbeLocations",
					angular_path,
					"--ngProbeLocations",
					angular_path,
				}

				lspconfig["angularls"].setup({
					cmd = angular_cmd,
					capabilities = capabilities,
					-- root_dir = util.root_pattern("angular.json", "project.json", "nx.json"),
					root_dir = util.root_pattern("angular.json"),
					on_new_config = function(new_config, new_root_dir)
						new_config.cmd = angular_cmd
					end,
				})
			end,
		})
	end,
}
