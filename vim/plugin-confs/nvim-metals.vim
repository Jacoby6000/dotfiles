lua << EOF
  local cmd = vim.cmd

  metals_config = require("metals").bare_config()

  -- Example of settings
  metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" }
  }

  metals_config.init_options.statusBarProvider = "on"

  metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

  metals_config.init_options.statusBarProvider = "on"

  metals_config.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = {
        prefix = '😡',
      }
    }
  )

  cmd [[augroup lsp]]
  cmd [[au!]]
  cmd [[au FileType scala,sbt setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
  cmd [[au FileType scala,sbt,java lua require("metals").initialize_or_attach(metals_config)]]
  cmd [[augroup end]]
EOF


