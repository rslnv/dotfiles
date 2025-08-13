return {
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    config = function()
      vim.g.undotree_WindowLayout = 2
    end,
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {
      render = "virtual",
      virtual_symbol = "",
    },
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  { "Hoffs/omnisharp-extended-lsp.nvim" },
}
