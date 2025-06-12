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
      "bash",
      "c",
      "c_sharp",
      "angular",
      "typescript",
      "javascript",
      "html",
      "http",
      "css",
      "scss",
      "yaml",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
