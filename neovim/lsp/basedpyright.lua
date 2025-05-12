return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { ".git", "pyproject.toml", "requirements.txt", "setup.py", "setup.cfg" },
  settings = {
    basedpyright = {
      analysis = {
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = "workspace",
        diagnosticSeverityOverrides = {
          reportConstantRedefinition = true,
          reportMissingTypeStubs = true,
          reportUnknownVariableType = true,
          reportUnusedParameter = false,
        },
        typeCheckingMode = "recommended",
      },
    },
  },
}
