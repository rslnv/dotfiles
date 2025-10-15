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
      { "<leader>d", group = "Debugger", icon = { icon = "", color = "cyan" } },
      { "<leader>dd", group = "Session", icon = { icon = "", color = "cyan" } },

      { "<leader>ddr", icon = { icon = "", color = "green" } },
      { "<leader>ddi", icon = { icon = "", color = "blue" } },
      { "<leader>ddo", icon = { icon = "", color = "purple" } },
      { "<leader>ddO", icon = { icon = "", color = "blue" } },
      { "<leader>ddb", icon = { icon = "", color = "blue" } },
      { "<leader>ddp", icon = { icon = "", color = "grey" } },
      { "<leader>ddR", icon = { icon = "", color = "orange" } },
      { "<leader>ddt", icon = { icon = "", color = "red" } },
      { "<leader>ddc", icon = { icon = "", color = "red" } },

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
