local LazyMapping = require("lib.lazy_mapping")

return {
  "hedyhli/outline.nvim",
  lazy = true,
  cmd = { "Outline", "OutlineOpen" },
  keys = { 
    LazyMapping.map("<leader>o", "Toggle outline", "<cmd>Outline<CR>"),
  },
}
