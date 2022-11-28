-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
return {
  cmd = { "dotnet", "~/.cache/nvim/lspconfig/omnisharp/run" },
  organize_imports_on_format = true,
  enable_import_completion = true,

  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,
  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is true
  analyze_open_documents_only = false,
}
