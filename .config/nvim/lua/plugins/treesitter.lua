return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "vimdoc",
      "lua",
      "c",
      "c_sharp",
      "angular",
      "typescript",
      "javascript",
      "html",
      "css",
      "scss",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
