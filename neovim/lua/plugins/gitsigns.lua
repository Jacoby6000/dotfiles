local LazyMapping = require("lib.lazy_mapping")

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {},
  keys = function()
    local gitsigns = require("gitsigns")
    return {
      LazyMapping.map("<leader>hs", "Git stage hunk", gitsigns.stage_hunk),
      LazyMapping.map("<leader>hr", "Git reset hunk", gitsigns.reset_hunk),
      LazyMapping.map("<leader>hS", "Git stage buffer", gitsigns.stage_buffer),
      LazyMapping.map("<leader>hu", "Git unstage hunk", gitsigns.undo_stage_hunk),
      LazyMapping.map("<leader>hR", "Git reset buffer", gitsigns.reset_buffer),
      LazyMapping.map("<leader>hp", "Git preview hunk", gitsigns.preview_hunk),
      LazyMapping.map("<leader>hb", "Git blame line", function()
        gitsigns.blame_line({ full = true })
      end),
      LazyMapping.map("<leader>tb", "Toggle Git blame line", gitsigns.toggle_current_line_blame),
      LazyMapping.map("<leader>hd", "Git diff", gitsigns.diffthis),
      LazyMapping.map("<leader>hD", "Git diff ~", function()
        gitsigns.diffthis("~")
      end),
      LazyMapping.map("<leader>td", "Show deleted git lines", gitsigns.toggle_deleted),
    }
  end,
}
