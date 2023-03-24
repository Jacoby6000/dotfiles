lua <<EOF
  require'lspconfig'.terraformls.setup{}
EOF
autocmd BufWritePre *.tfvars lua vim.lsp.buf.formatting_sync()
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()
