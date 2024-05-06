local M = {}

function M.noremap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function M.nnoremap(lhs, rhs, opts)
  M.noremap("n", lhs, rhs, opts)
end

return M
