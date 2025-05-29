return {
  "mason-org/mason-lspconfig.nvim",
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason-lspconfig").setup()

    local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
    local servers = vim
      .iter(vim.fn.readdir(lsp_dir))
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      :totable()

    local ensure_installed = {
      "stylua",
      "prettier",
      "netcoredbg",
    }
    vim.list_extend(ensure_installed, servers)

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    -- for server_name, config in pairs(mason_helper.servers) do
    --   vim.print(server_name, config)
    --   vim.lsp.config(server_name, config)
    --   vim.lsp.enable(server_name)
    -- end
  end,
}
