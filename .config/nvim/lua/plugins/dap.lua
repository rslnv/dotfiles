return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dap_utils = require("dap.utils")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")

    dapui.setup({
      expand_lines = true,
      -- controls = { enabled = false }, -- no extra play/step buttons
      floating = { border = "rounded" },
      -- Set dapui window
      render = {
        max_type_length = 60,
        max_value_lines = 200,
      },
      -- Only one layout: just the "scopes" (variables) list at the bottom
      layouts = {
        {
          elements = {
            { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
          },
          size = 15, -- height in lines (adjust to taste)
          position = "bottom", -- "left", "right", "top", "bottom"
        },
      },
    })

    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
      args = { "--interpreter=vscode" },
    }
    dap.history = {
      cs = {
        args = "",
      },
    }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "Attach to process",
        request = "attach", -- "attach" | "launch"
        processId = dap_utils.pick_process,
      },
      {
        type = "coreclr",
        name = "Launch",
        request = "launch", -- "attach" | "launch"
        program = require("utils.builder").dotnet_build_and_pick_dll,
      },
      {
        type = "coreclr",
        name = "Launch with args",
        request = "launch",
        program = require("utils.builder").dotnet_build_and_pick_dll,
        args = function()
          dap.history.cs.args = vim.fn.input("Arguments: ", dap.history.cs.args)
          return vim.split(dap.history.cs.args, " ")
        end,
      },
    }

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        -- args = { "/path/to/js-debug/src/dapDebugServer.js", "${port}" },
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }
    dap.configurations.typescript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        runtimeExecutable = "deno",
        runtimeArgs = {
          "run",
          "--inspect-wait",
          "--allow-all",
        },
        program = "${file}",
        cwd = "${workspaceFolder}",
        attachSimplePort = 9229,
      },
    }

    vim.keymap.set("n", "<leader>de", dapui.eval, { desc = "Evaluate" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "Set Breakpoint" })
    vim.keymap.set("n", "<leader>dL", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Log breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last Cofiguration" })

    vim.keymap.set({ "n", "v" }, "<Leader>dh", widgets.hover, { desc = "Hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>dp", widgets.preview, { desc = "Preview" })

    vim.keymap.set("n", "<Leader>dr", function()
      require("dap").repl.toggle()
    end, { desc = "REPL" })

    vim.keymap.set("n", "<leader>ddr", dap.continue, { desc = "Run" })
    vim.keymap.set("n", "<leader>ddi", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>ddo", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>ddO", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>ddb", dap.step_back, { desc = "Step Back" })
    vim.keymap.set("n", "<leader>ddp", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<leader>ddR", dap.restart, { desc = "Restart" })
    vim.keymap.set("n", "<leader>ddt", dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<leader>ddc", dap.close, { desc = "Close without terminating" })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- https://emojipedia.org/en/stickers/search?q=circle
    -- vim.fn.sign_define("DapBreakpoint", {
    --   text = "",
    --   texthl = "DapBreakpointSymbol",
    --   linehl = "DapBreakpoint",
    --   numhl = "DapBreakpoint",
    -- })
    --
    -- vim.fn.sign_define("DapStopped", {
    --   text = "",
    --   texthl = "yellow",
    --   linehl = "DapBreakpoint",
    --   numhl = "DapBreakpoint",
    -- })
    -- vim.fn.sign_define("DapBreakpointRejected", {
    --   text = "",
    --   texthl = "DapStoppedSymbol",
    --   linehl = "DapBreakpoint",
    --   numhl = "DapBreakpoint",
    -- })
    local signs = {
      DapBreakpoint = { text = "", texthl = "SignColumn", linehl = "", numhl = "" },
      DapBreakpointCondition = { text = "", texthl = "SignColumn", linehl = "", numhl = "" },
      DapBreakpointRejected = { text = "", texthl = "SignColumn", linehl = "", numhl = "" },
      DapLogPoint = { text = "", texthl = "SignColumn", linehl = "", numhl = "" },
      DapStopped = { text = "", texthl = "SignColumn", linehl = "debugPC", numhl = "" },
    }

    -- local function sign_try_define(name)
    --   local s = vim.fn.sign_getdefined(name)
    --   if vim.tbl_isempty(s) then
    --     local opts = signs[name]
    --     vim.fn.sign_define(name, opts)
    --   end
    -- end

    for name in pairs(signs) do
      local opts = signs[name]
      vim.fn.sign_define(name, opts)
    end

    -- DapBreakpoint = { text = "B", texthl = "SignColumn", linehl = "", numhl = "" },
    -- DapBreakpointCondition = { text = "C", texthl = "SignColumn", linehl = "", numhl = "" },
    -- DapBreakpointRejected = { text = 'R', texthl = "SignColumn", linehl = '', numhl = '' },
    -- DapLogPoint = { text = 'L', texthl = "SignColumn", linehl = '', numhl = '' },
    -- DapStopped = { text = '→', texthl = "SignColumn", linehl = 'debugPC', numhl = '' },
    --
    --   vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
  end,
}
