return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<S-h>", "<CMD>bprev<CR>", desc = "Buffer prev" },
    { "<S-l>", "<CMD>bnext<CR>", desc = "Buffer next" },
  },
}
