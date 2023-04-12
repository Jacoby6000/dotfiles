inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <silent> <c-enter> <Plug>(completion_trigger)

set completeopt=menu,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
set shortmess-=F

lua << EOF
  local cmd = vim.cmd
  local api = vim.api

  local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
  map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
  map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
  map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
  map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
  map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
  map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
  map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
  map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, } , -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ["<S-Tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = 'copilot', group_index = 2 },
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['pyright'].setup {}
  
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

  local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
  api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
  
  local ht = require('haskell-tools')
  local buffer = vim.api.nvim_get_current_buf()
  local def_opts = { noremap = true, silent = true, }
  ht.setup {
    hls = {
      on_attach = function(client, bufnr)
        local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
      end,
    },
  }
EOF

