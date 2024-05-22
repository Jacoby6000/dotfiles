local LazyMapping = require("lib.lazy_mapping")

return {
  "mfussenegger/nvim-dap",
  keys = function()
    local dap = require("dap")
    return {
      LazyMapping.map("<leader>dc", "Continue DAP Execution", function()
        dap.continue()
      end),

      LazyMapping.map("<leader>dr", "Toggle DAP Repl", function()
        dap.repl.toggle()
      end),

      LazyMapping.map("<leader>dK", "Show DAP hover info", function()
        require("dap.ui.widgets").hover()
      end),
      LazyMapping.map("<leader>dt", "Toggle DAP Breakpoint", function()
        dap.toggle_breakpoint()
      end),

      LazyMapping.map("<leader>dso", "Step over function in DAP", function()
        dap.step_over()
      end),

      LazyMapping.map("<leader>dsi", "Step in to function in DAP", function()
        dap.step_into()
      end),

      LazyMapping.map("<leader>dl", "Rerun last execution with DAP", function()
        dap.run_last()
      end),
    }
  end,
}
