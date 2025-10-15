return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "gruvbox",
    },
    sections = {
      lualine_x = {
        {
          "rest",
          icon = "",
          fg = "#428890",
        },
        "lsp_status",
        "encoding",
        "fileformat",
        "filetype",
      },
    },
  },
}
