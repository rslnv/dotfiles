return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
      ensure_installed = { "lua", "c_sharp", "angular", "typescript", "javascript", "html", "css", "scss" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
