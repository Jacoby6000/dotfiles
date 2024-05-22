local M = {}

function M.map(keys, description, func, opts)
  opts = opts or {}
  opts.desc = description
  return { keys, func, opts }
end

return M
