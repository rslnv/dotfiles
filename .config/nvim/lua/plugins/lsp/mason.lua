local status_ok, mason = pcall(require, "mason")
if not status_ok then
	print("mason is not available")
	return
end

local config_status_ok, mason_config = pcall(require, "mason-lspconfig")
if not config_status_ok then
	print("mason-lspconfig is not available")
	return
end

local servers = {
	"angularls",
	"sumneko_lua",
	"omnisharp",
}

mason.setup()
mason_config.setup({
	ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local custom_opts = require("plugins.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	end

	if server == "omnisharp" then
		local custom_opts = require("plugins.lsp.settings.omnisharp")
		opts = vim.tbl_deep_extend("force", custom_opts, opts)
	end

	lspconfig[server].setup(opts)
end
