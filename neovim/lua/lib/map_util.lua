local M = {}

function M.noremap(mode, lhs, description, rhs, opts)
  local options = { noremap = true, silent = true, desc = description }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.nnoremap(lhs, description, rhs, opts)
  M.noremap("n", lhs, description, rhs, opts)
end

return M
