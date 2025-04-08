local M = {}

local function extract_dll_paths(stdout)
  local results = {}
  local idx, s, e

  while true do
    idx, s = string.find(stdout, "-> ", idx)
    if s == nil then
      break
    end

    s = s + 1
    e, idx = string.find(stdout, "\n", s)
    if e == nil then
      break
    end

    local dll_path = string.sub(stdout, s, e - 1)
    -- vim.print("substring", s, e, dll_path)
    table.insert(results, dll_path)
  end
  -- vim.print(results)
  return results
end

function M.dotnet_build_and_list_dlls()
  local command_result = vim.system({ "dotnet", "build", "--configuration", "Debug" }, { text = true }):wait()
  if command_result.stdout == nil then
    vim.notify("Build process failed: " .. command_result.stderr, vim.log.levels.ERROR)
    return {}
  else
    local result = extract_dll_paths(command_result.stdout)
    return result
  end
end

return M
