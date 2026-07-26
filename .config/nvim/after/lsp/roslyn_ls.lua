-- dotnet tool install --global roslyn-language-server --prerelease

---@type vim.lsp.Config
return {
  filetypes = { "razor", "cs" },

  -- better performance
  -- ["csharp|background_analysis"] = {
  --   dotnet_analyzer_diagnostics_scope = "openFiles",
  --   dotnet_compiler_diagnostics_scope = "openFiles",
  -- },
}
