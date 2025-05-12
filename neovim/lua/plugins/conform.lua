local LazyMapping = require("lib.lazy_mapping")

return {
  "stevearc/conform.nvim",
  opts = function()
    return {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        scala = { "scalafmt" },
        rust = { "rustfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }
  end,
  keys = {
    LazyMapping.map("<leader>fF", "Format file", function()
      require("conform").format()
    end),
  },
}
