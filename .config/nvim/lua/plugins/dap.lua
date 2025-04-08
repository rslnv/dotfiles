return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
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
        name = "launch - netcoredbg",
        request = "launch", -- "attach" | "launch"
        -- program = get_program,
        program = function()
          vim.print("Starting build process")

          return coroutine.create(function(dap_run_co)
            local items = require("utils.builder").dotnet_build_and_list_dlls()
            if table.getn(items) == 0 then
              coroutine.resume(dap_run_co, dap.ABORT)
            else
              vim.ui.select(items, { prompt = "Select dll" }, function(choice)
                choice = choice or dap.ABORT
                coroutine.resume(dap_run_co, choice)
              end)
            end
          end)
        end,
      },
      -- {
      --   type = "coreclr",
      --   name = "launch with args - netcoredbg",
      --   request = "launch",
      --   program = get_program,
      --   args = function()
      --     dap.history.cs.args = vim.fn.input("Arguments: ", dap.history.cs.args)
      --     return vim.split(dap.history.cs.args, " ")
      --   end,
      -- },
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
    vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Step Out" })
    vim.keymap.set("n", "<F6>", dap.pause, { desc = "Pause" })
    vim.keymap.set("n", "<F7>", dap.restart, { desc = "Restart" })
    vim.keymap.set("n", "<F8>", dap.terminate, { desc = "Terminate" })
    vim.keymap.set("n", "<F9>", dap.close, { desc = "Close without terminating" })

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
