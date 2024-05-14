return  --[[{
  "shawilly/ponokai",
  priority = 1000,
  config = function()
    vim.g.ponokai_style = "default"
    vim.cmd.colorscheme("ponokai")
    -- Enable transparent background with vim.g.ponokai_transparent_background = "1"
  end,
}]]{
  "themercorp/themer.lua",
  config = function()
    require("themer").setup({
      colorscheme = "monokai_pro",
      styles = {},
    })
  end,
}
