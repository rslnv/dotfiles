local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Text" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Command history" })
vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Registers" })
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })

vim.keymap.set("n", "<leader>ec", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Config files" })
vim.keymap.set("n", "<leader>eC", function()
  builtin.live_grep({ cwd = vim.fn.stdpath("config") })
end, { desc = "Config text" })

vim.keymap.set("n", "<leader>ep", function()
  local cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
  builtin.find_files({ cwd = cwd })
end, { desc = "Plugins files" })
vim.keymap.set("n", "<leader>eP", function()
  local cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
  builtin.live_grep({ cwd = cwd })
end, { desc = "Plugins text" })

vim.keymap.set("n", "<leader>xs", "<CMD>source %<CR>", { desc = "Source file" })
vim.keymap.set("n", "<leader>xx", ":.lua<CR>", { desc = "Execute line" })
vim.keymap.set("v", "<leader>xx", ":lua<CR>", { desc = "Execute selection" })

-- move selected text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Clear search highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostic prev" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostic next" })
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Quickfix list" })
vim.keymap.set("n", "<leader>qq", builtin.diagnostics, { desc = "Global diagnostics" })
vim.keymap.set("n", "<leader>qb", function()
  builtin.diagnostics({ bufnr = 0 })
end, { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>ql", vim.diagnostic.open_float, { desc = "Line diagnostics" })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undo History" })

-- Quickfix
vim.keymap.set("n", "[c", "<CMD>cprev<CR>", { desc = "Quickfix prev" })
vim.keymap.set("n", "]c", "<CMD>cnext<CR>", { desc = "Quickfix next" })
