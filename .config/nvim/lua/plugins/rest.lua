return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>rr", "<CMD>Rest run<CR>", desc = "Run current" },
    { "<leader>rl", "<CMD>Rest last<CR>", desc = "Run last" },
    {
      "<leader>re",
      function()
        require("telescope").extensions.rest.select_env()
      end,
      desc = "Select environment",
    },
  },
}
