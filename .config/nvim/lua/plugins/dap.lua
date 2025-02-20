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
    -- dapui.setup({
    -- 	layouts = {
    -- 		{
    -- 			elements = {
    -- 				{ id = "scopes", size = 0.8 },
    -- 				{ id = "breakpoints", size = 0.2 },
    -- 			},
    -- 			size = 0.3,
    -- 			position = "left",
    -- 		},
    -- 		{
    -- 			elements = {
    -- 				{ id = "stacks", size = 0.3 },
    -- 				{ id = "watches", size = 0.4 },
    -- 				{ id = "console", size = 0.3 },
    -- 			},
    -- 			size = 0.2,
    -- 			position = "right",
    -- 		},
    -- 		{
    -- 			elements = {
    -- 				"repl",
    -- 			},
    -- 			size = 20,
    -- 			position = "bottom",
    -- 		},
    -- 	},
    -- })

    -- require("nvim-dap-virtual-text").setup({})

    local function get_program()
      local result = vim.system({ "dotnet", "build" }, { text = true }):wait()
      local stdout = result.stdout or ""
      local _, s = string.find(stdout, "-> ")

      if s ~= nil then
        s = s + 1
        local e = string.find(stdout, "\n", s)
        if e ~= nil then
          return stdout.sub(stdout, s, e - 1)
        end
      end

      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
    end

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
        program = get_program,
      },
      {
        type = "coreclr",
        name = "launch with args - netcoredbg",
        request = "launch",
        program = get_program,
        args = function()
          dap.history.cs.args = vim.fn.input("Arguments: ", dap.history.cs.args)
          return vim.split(dap.history.cs.args, " ")
        end,
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
