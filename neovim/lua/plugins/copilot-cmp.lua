local LSP = require("lib.lsp")
return {
  "zbirenbaum/copilot-cmp",
  lazy = true,
  dependencies = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  opts = {},
  config = function(_, opts)
    local copilot_cmp = require("copilot_cmp")
    copilot_cmp.setup(opts)
    LSP.on_attach(function(client)
      if client.name == "copilot" then
        copilot_cmp._on_insert_enter({})
      end
    end)
  end,
}
