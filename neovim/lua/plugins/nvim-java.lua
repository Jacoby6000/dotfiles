local MapUtil = require("lib.map_util")

return {
  "nvim-java/nvim-java",
  -- ft = { "java", "xml", "gradle" },
  -- lazy = true,
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "nvim-java/nvim-java-refactor",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    {
      "williamboman/mason.nvim",
      opts = {
        registries = {
          "github:nvim-java/mason-registry",
          "github:mason-org/mason-registry",
        },
      },
    },
  },
  config = function()
    local java = require("java")
    java.setup()
    require("lspconfig").jdtls.setup({})

    MapUtil.nnoremap("<leader>tc", java.test.run_current_class, { desc = "Run current test class" })
    MapUtil.nnoremap("<leader>tm", java.test.run_current_method, { desc = "Run current test method" })
    MapUtil.nnoremap("<leader>tr", java.test.view_last_report, { desc = "View last test report" })
  end,
}
