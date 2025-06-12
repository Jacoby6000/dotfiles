return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      options = {
        show_source = {
          enabled = true,
          if_many = true,
        },
        multilines = {
          enabled = true,
          always_show = true,
        },
      },
    })
    vim.diagnostic.config({ virtual_text = false })
  end,
}
