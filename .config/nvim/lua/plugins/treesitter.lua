return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "angular",
      "bash",
      "c",
      "c_sharp",
      "css",
      "html",
      "http",
      "javascript",
      "lua",
      "scss",
      "typescript",
      "vimdoc",
      "yaml",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
