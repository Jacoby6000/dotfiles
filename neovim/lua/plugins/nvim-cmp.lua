local LM = require("lib.lazy_mapping")

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "zbirenbaum/copilot-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  keys = {
    LM.map("gD", "Go to definition", vim.lsp.buf.definition),
    LM.map("K", "Show hover text", vim.lsp.buf.hover),
    LM.map("gi", "Go to implementations", vim.lsp.buf.implementation),
    LM.map("gr", "Show references", vim.lsp.buf.references),
    LM.map("gds", "Show documentation", vim.lsp.buf.document_symbol),
    LM.map("gws", "Show workspace symbol", vim.lsp.buf.workspace_symbol),
    LM.map("<leader>cl", "Run codelens", vim.lsp.codelens.run),
    LM.map("<leader>sh", "Show signature", vim.lsp.buf.signature_help),
    LM.map("<leader>rn", "Rename", vim.lsp.buf.rename),
    LM.map("<leader>f", "Format source", vim.lsp.buf.format),
    LM.map("<leader>ca", "Show code actions", vim.lsp.buf.code_action),

    -- all workspace diagnostics
    LM.map("<leader>aa", "Show all diagnostics", vim.diagnostic.setqflist),

    -- all workspace errors
    LM.map("<leader>ae", "Show all errors", function()
      vim.diagnostic.setqflist({ severity = "E" })
    end),

    -- all workspace warnings
    LM.map("<leader>aw", "Show all warnings", function()
      vim.diagnostic.setqflist({ severity = "W" })
    end),

    -- buffer diagnostics only
    LM.map("<leader>d", "Show current buffer diagnostics", vim.diagnostic.setloclist),

    LM.map("[c", "Go to previous diagnostic", function()
      vim.diagnostic.goto_prev({ wrap = false })
    end),

    LM.map("]c", "Go to next diagnostic", function()
      vim.diagnostic.goto_next({ wrap = false })
    end),
  },
  opts = function(_, opts)
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    opts.completion = { completeopt = "menu,menuone,preview,noinsert,noselect" }
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<TAB>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<S-TAB>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    })
    opts.sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_document_symbol" },
      { name = "nvim_lsp_signature_help" },
      { name = "rg" }, --ripgrep results
      { name = "buffer" },
      { name = "path" },
      { name = "nvim_lua" }, -- neovim lua api
      { name = "luasnip" },
      { name = "copilot", group_index = 1, priority = 100 },
    }
    opts.formatting = {
      format = function(_, item)
        local icons = require("config.icons").kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    }
    opts.experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    }
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
  end,
  config = function(_, opts)
    for _, source in ipairs(opts.sources) do
      source.group_index = source.group_index or 1
    end
    local cmp = require("cmp")
    local Kind = cmp.lsp.CompletionItemKind
    cmp.setup(opts)
    cmp.event:on("confirm_done", function(event)
      if not vim.tbl_contains(opts.auto_brackets or {}, vim.bo.filetype) then
        return
      end
      local entry = event.entry
      local item = entry:get_completion_item()
      if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
        local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
        vim.api.nvim_feedkeys(keys, "i", true)
      end
    end)
  end,
}
