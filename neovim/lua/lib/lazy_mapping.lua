local M = {}

function M.map(keys, description, func, opts)
  return { keys, func, desc = description, opts }
end

return M
