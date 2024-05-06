local LazyMapping = require("lib.lazy_mapping")
local Files = require("lib.files")

local lazygitTerm = nil
local floatingTerm = nil
local bottomTerm = nil

local terms = {}

local function toggle_terminal(idx, cmd, direction, directory)
  directory = directory or Files.get_project_root()
  return function()
    if terms[idx] == nil then
      terms[idx] = require("toggleterm.terminal").Terminal:new({
        cmd = cmd,
        direction = direction,
        hidden = true,
        dir = directory,
        name = idx,
      })
    end
    terms[idx]:toggle()
  end
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {},
  keys = function()
    return {
      LazyMapping.map("<leader>sc", "Toggle lazygit", toggle_terminal("lazygit", "lazygit", "float")),
      LazyMapping.map("<leader>tt", "Toggle terminal", toggle_terminal("bottom_zsh", "zsh", "horizontal")),
      LazyMapping.map("<leader>tT", "Toggle terminal", toggle_terminal("float_zsh", "zsh", "float")),
    }
  end,
}
