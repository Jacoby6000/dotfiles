local Files = require("lib.files")
local LazyMapping = require("lib.lazy_mapping")

local neotree_cwd_cmd = "<cmd>Neotree toggle reveal<cr>"
local neotree_project_root_cmd = "<cmd>Neotree toggle reveal dir=" .. Files.get_project_root() .. "<cr>"

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    filesystem = {
      group_empty_dirs = true,
    },

    source_selector = {
      -- winbar = true,
    },
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      --      "document_symbols",
    },
  },
  keys = {
    LazyMapping.map("<leader>n", "Open neotree filebrowser at the project root or cwd", neotree_project_root_cmd),
    LazyMapping.map("<leader>N", "Open neotree filebrowser at the cwd", neotree_cwd_cmd),
  },
}
