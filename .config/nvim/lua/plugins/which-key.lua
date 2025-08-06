return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps",
    },
  },
  config = function()
    require("which-key").add({
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debugger" },
      { "<leader>e", group = "Edit" },
      { "<leader>f", group = "Find" },
      { "<leader>h", group = "Hunk" },
      { "<leader>q", group = "Diagnostics" },
      { "<leader>r", group = "Rest" },
      { "<leader>t", group = "Test" },
      { "<leader>x", group = "Execute" },
      { "<leader>w", group = "Workspace" },
    })
  end,
}
