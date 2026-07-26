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

    local lsp_dir = vim.fn.stdpath("config") .. "/after/lsp"
    local servers = vim
      .iter(vim.fn.readdir(lsp_dir))
      -- only interested in lua files
      :filter(function(file)
        return file:match("%.lua$")
      end)
      :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
      end)
      -- roslyn_ls is installed manually
      :filter(function(lsp)
        return lsp ~= "roslyn_ls"
      end)
      :totable()

    local ensure_installed = {
      "stylua",
      "prettier",
      "netcoredbg",
    }
    vim.list_extend(ensure_installed, servers)

    -- vim.print(ensure_installed)

    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    vim.lsp.enable("roslyn_ls")

    -- for server_name, config in pairs(mason_helper.servers) do
    --   vim.print(server_name, config)
    --   vim.lsp.config(server_name, config)
    --   vim.lsp.enable(server_name)
    -- end
  end,
}
