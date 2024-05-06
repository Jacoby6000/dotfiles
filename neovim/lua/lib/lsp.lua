local M = {}

function M.on_attach(on_attach_callback)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach_callback(client, buffer)
    end,
  })
end

return M
