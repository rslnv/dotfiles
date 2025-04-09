local M = {}

local dap = require("dap")

local function extract_dll_paths(stdout)
  local results = {}
  local s, e

  while true do
    _, e = string.find(stdout, "-> ", e)
    if e == nil then
      break
    end

    s, _ = string.find(stdout, "\n", e + 1)
    if s == nil then
      break
    end

    local dll_path = string.sub(stdout, e + 1, s - 1)
    e = s + 1

    table.insert(results, dll_path)
  end

  return results
end

function M.dotnet_build_and_pick_dll()
  return coroutine.create(function(dap_run_co)
    local build_res = vim.system({ "dotnet", "build", "--configuration", "Debug" }, { text = true }):wait()

    if build_res.code ~= 0 then
      vim.print("Build process failed:\n\n" .. build_res.stdout)
      coroutine.resume(dap_run_co, dap.ABORT)
    else
      local items = extract_dll_paths(build_res.stdout)
      if #items == 0 then
        vim.print("No dlls to choose from")
        coroutine.resume(dap_run_co, dap.ABORT)
      else
        vim.ui.select(items, { prompt = "Select dll" }, function(choice)
          choice = choice or dap.ABORT
          coroutine.resume(dap_run_co, choice)
        end)
      end
    end
  end)
end

return M
