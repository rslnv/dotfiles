vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("UserHighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    --HACK: disable angular renaming capability due to duplicate rename popping up
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.config.name == "angularls" then
      client.server_capabilities.renameProvider = false
    end

    local telescope_builtin = require("telescope.builtin")
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("error", opts, { desc = "Jump to declaration" }))
    vim.keymap.set(
      "n",
      "gd",
      telescope_builtin.lsp_definitions,
      -- vim.lsp.buf.definition,
      vim.tbl_extend("error", opts, { desc = "List definitions" })
    )
    vim.keymap.set(
      "n",
      "gt",
      telescope_builtin.lsp_type_definitions,
      -- vim.lsp.buf.type_definition,
      vim.tbl_extend("error", opts, { desc = "List type definition" })
    )
    vim.keymap.set(
      "n",
      "gi",
      telescope_builtin.lsp_implementations,
      -- vim.lsp.buf.implementation,
      vim.tbl_extend("error", opts, { desc = "List implementations" })
    )
    vim.keymap.set(
      "n",
      "gr",
      telescope_builtin.lsp_references,
      -- vim.lsp.buf.references,
      vim.tbl_extend("error", opts, { desc = "List references" })
    )

    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("error", opts, { desc = "Symbol info" }))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("error", opts, { desc = "Signature help" }))

    vim.keymap.set(
      "n",
      "<leader>wa",
      vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend("error", opts, { desc = "Add workspace folder" })
    )
    vim.keymap.set(
      "n",
      "<leader>wr",
      vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend("error", opts, { desc = "Remove workspace folder" })
    )
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("error", opts, { desc = "List workspace folders" }))

    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("error", opts, { desc = "Rename symbol" }))
    vim.keymap.set(
      { "n", "v" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("error", opts, { desc = "Actions" })
    )

    -- more tsserver specific code actions
    -- https://www.lazyvim.org/extras/lang/typescript
    -- https://www.reddit.com/r/neovim/comments/192jxlv/how_to_get_tsserver_auto_add_imports_on_save/
    -- https://neovim.io/doc/user/lsp.html
    -- if client and client.config.name == "tsserver" then
    if client and client.config.name == "ts_ls" then
      vim.keymap.set("n", "<leader>co", function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
      end, vim.tbl_extend("error", opts, { desc = "Organize imports" }))

      vim.keymap.set("n", "<leader>cm", function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" } } })
      end, vim.tbl_extend("error", opts, { desc = "Add missing imports" }))

      vim.keymap.set("n", "<leader>cu", function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" } } })
      end, vim.tbl_extend("error", opts, { desc = "Remove unused imports" }))
    end
  end,
})

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
-- 	desc = "Do linting",
-- 	group = vim.api.nvim_create_augroup("UserLinting", { clear = true }),
-- 	callback = function()
-- 		local status_ok, lint = pcall(require, "lint")
-- 		if not status_ok then
-- 			print("linting is not available")
-- 			return
-- 		end
-- 		lint.try_lint()
-- 	end,
-- })
