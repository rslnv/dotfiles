return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        window = {
          position = "current",
        },
        -- hijack_netrw_behavior = "open_default",
      },
    })
  end,
  keys = {
    { "<leader>e", "<CMD>Neotree toggle=true<CR>", desc = "File tree" },
    -- { "<leader>e", "<CMD>Neotree position=current toggle=true<CR>", desc = "File tree" },
  },
}
