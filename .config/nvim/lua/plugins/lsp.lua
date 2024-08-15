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
          "tsserver",
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
      local util = require("lspconfig.util")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
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
          },
        },
      })

      lspconfig.omnisharp.setup({
        capabilities = capabilities,
        cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
      })
      -- lspconfig.csharp_ls.setup({ capabilities = capabilities })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        -- init_options = {
        -- 	preferences = {
        -- 		importModuleSpecifierPreference = "relative",
        -- 	},
        -- },
      })

      local angular_path = "/usr/lib/node_modules/"
      -- -- local angular_path = vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules"
      local angular_cmd = {
        "ngserver",
        "--stdio",
        "--tsProbeLocations",
        angular_path,
        "--ngProbeLocations",
        angular_path,
      }
      --
      lspconfig.angularls.setup({
        cmd = angular_cmd,
        capabilities = capabilities,
        -- root_dir = util.root_pattern("angular.json", "project.json", "nx.json"),
        root_dir = util.root_pattern("angular.json"),
        on_new_config = function(new_config, new_root_dir)
          new_config.cmd = angular_cmd
        end,
      })
    end,
  },
}
