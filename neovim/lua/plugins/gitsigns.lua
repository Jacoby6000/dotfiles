local LazyMapping = require("lib.lazy_mapping")

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {},
  keys = function()
    local gitsigns = require("gitsigns")
    return {
      LazyMapping.map("<leader>hs", "Git (h)unk (s)tage", gitsigns.stage_hunk),
      LazyMapping.map("<leader>hr", "Git (h)unk (r)eset", gitsigns.reset_hunk),
      LazyMapping.map("<leader>bS", "Git (b)uffer (S)tage", gitsigns.stage_buffer),
      LazyMapping.map("<leader>hu", "Git (h)unk (u)nstage", gitsigns.undo_stage_hunk),
      LazyMapping.map("<leader>bR", "Git (b)uffer (R)eset", gitsigns.reset_buffer),
      LazyMapping.map("<leader>hp", "Git (h)unk (p)review", gitsigns.preview_hunk),
      LazyMapping.map("<leader>hb", "Git blame line", function()
        gitsigns.blame_line({ full = true })
      end),
      LazyMapping.map("<leader>tb", "Toggle Git blame line", gitsigns.toggle_current_line_blame),
      LazyMapping.map("<leader>hd", "Git diff", gitsigns.diffthis),
      LazyMapping.map("<leader>hD", "Git diff ~", function()
        gitsigns.diffthis("~")
      end),
      LazyMapping.map("<leader>td", "(t)oggle (d)eleted git lines", gitsigns.toggle_deleted),
    }
  end,
}
