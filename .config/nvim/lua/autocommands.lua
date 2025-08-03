vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("UserHighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
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
    -- local opts = { buffer = ev.buf, silent = true }

    local function opts(desc)
      local o = { buffer = ev.buf, silent = true }
      return vim.tbl_extend("error", o, { desc = desc })
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Jump to declaration"))
    vim.keymap.set(
      "n",
      "gd",
      -- vim.lsp.buf.definition,
      function()
        if client and client.config.name == "omnisharp" then
          require("omnisharp_extended").telescope_lsp_definition()
        else
          telescope_builtin.lsp_definitions()
        end
      end,
      opts("List definitions")
    )
    vim.keymap.set(
      "n",
      "grt",
      -- vim.lsp.buf.type_definition,
      function()
        if client and client.config.name == "omnisharp" then
          require("omnisharp_extended").telescope_lsp_type_definition()
        else
          telescope_builtin.lsp_type_definitions()
        end
      end,
      opts("List type definition")
    )
    vim.keymap.set(
      "n",
      "gri",
      -- vim.lsp.buf.implementation,
      function()
        if client and client.config.name == "omnisharp" then
          require("omnisharp_extended").telescope_lsp_implementation()
        else
          telescope_builtin.lsp_implementations()
        end
      end,
      opts("List implementations")
    )
    vim.keymap.set(
      "n",
      "grr",
      -- vim.lsp.buf.references,
      function()
        if client and client.config.name == "omnisharp" then
          require("omnisharp_extended").telescope_lsp_references()
        else
          telescope_builtin.lsp_references()
        end
      end,
      opts("List references")
    )

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Symbol info"))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts("Signature help"))

    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("List workspace folders"))

    vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts("Rename symbol"))
    vim.keymap.set({ "n", "x" }, "gra", vim.lsp.buf.code_action, opts("Actions"))

    -- if client and client.config.name == "omnisharp" then
    --   vim.print(client.server_capabilities)
    -- end

    -- more tsserver specific code actions
    -- https://www.lazyvim.org/extras/lang/typescript
    -- https://www.reddit.com/r/neovim/comments/192jxlv/how_to_get_tsserver_auto_add_imports_on_save/
    -- https://neovim.io/doc/user/lsp.html
    -- if client and client.config.name == "tsserver" then
    if client and client.config.name == "ts_ls" then
      vim.keymap.set("n", "<leader>co", function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" } } })
      end, opts("Organize imports"))

      vim.keymap.set("n", "<leader>cm", function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" } } })
      end, opts("Add missing imports"))

      vim.keymap.set("n", "<leader>cu", function()
        vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" } } })
      end, opts("Remove unused imports"))
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
