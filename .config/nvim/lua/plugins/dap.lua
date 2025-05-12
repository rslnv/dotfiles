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

    dapui.setup()

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

    vim.keymap.set("n", "<leader>dd", function()
      dapui.eval(nil, { enter = true })
    end, { desc = "Evaluate" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", dap.set_breakpoint, { desc = "Set Breakpoint" })
    vim.keymap.set("n", "<leader>dL", function()
      dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Log breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.run_to_cursor, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last Cofiguration" })

    vim.keymap.set({ "n", "v" }, "<Leader>dh", widgets.hover, { desc = "Hover" })
    vim.keymap.set({ "n", "v" }, "<Leader>dp", widgets.preview, { desc = "Preview" })

    vim.keymap.set("n", "<F1>", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Step Back" })
    vim.keymap.set("n", "<F6>", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<F7>", dap.restart, { desc = "Restart" })
    vim.keymap.set("n", "<F8>", dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<F9>", dap.close, { desc = "Close without terminating" })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
