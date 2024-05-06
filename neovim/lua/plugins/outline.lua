local LazyMapping = require("lib.lazy_mapping")

return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    LazyMapping.map("<leader>o", "Toggle outline", "<cmd>Outline<CR>"),
  },
  opts = {
    -- Your setup opts here
  },
}
