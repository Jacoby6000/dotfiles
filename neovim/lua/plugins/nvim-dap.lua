local LazyMapping = require("lib.lazy_mapping")

return {
  "mfussenegger/nvim-dap",
  keys = function()
    local dap = require("dap")
    return {
      LazyMapping.map("<leader>dc", "Continue Execution", function()
        dap.continue()
      end),

      LazyMapping.map("<leader>dr", function()
        dap.repl.toggle()
      end),

      LazyMapping.map("<leader>dK", function()
        require("dap.ui.widgets").hover()
      end),
      LazyMapping.map("<leader>dt", function()
        dap.toggle_breakpoint()
      end),

      LazyMapping.map("<leader>dso", function()
        dap.step_over()
      end),

      LazyMapping.map("<leader>dsi", function()
        dap.step_into()
      end),

      LazyMapping.map("<leader>dl", function()
        dap.run_last()
      end),
    }
  end,
}
