local LM = require("lib.lazy_mapping")

return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      LM.map("<leader>ff", "Find files", "<cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>"),
      LM.map(
        "<leader>gg",
        "Find files in git",
        "<cmd>lua require('telescope.builtin').git_files({show_untracked=true})<cr>"
      ),
      LM.map(
        "<leader>go",
        "Find previously opened files",
        "<cmd>lua require('telescope.builtin').oldfiles({only_cwd=true})<cr>"
      ),
      LM.map("<leader>gs", "Search for string as you type", "<cmd>lua require('telescope.builtin').live_grep()<cr>"),
      LM.map(
        "<leader>gh",
        "Search for string under cursor or selection",
        "<cmd>lua require('telescope.builtin').grep_string()<cr>"
      ),
      LM.map(
        "<leader>bs",
        "List open buffers",
        "<cmd>lua require('telescope.builtin').buffers({show_all_buffers = false, sort_mru=true, ignore_current_buffer=false})<cr>"
      ),
      LM.map(
        "<leader>sp",
        "Show spelling suggestions for word under cursor",
        "<cmd>lua require('telescope.builtin').spell_suggest()<cr>"
      ),
      LM.map(
        "<leader>gb",
        "Find within the current buffer",
        "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"
      ),
      LM.map("<leader>tq", "List items in quickfix", require("telescope.builtin").quickfix),
      LM.map("<C-q>", "Send selection to quickfix", function()
        local actions = require("telescope.builtin")
        actions.smart_send_to_qflist()
        actions.open_qflist()
      end),
    }
  end,
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  tag = "0.1.6",
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
        },
      },
      defaults = {
        --   -- args for live_grep and grep_string
        vimgrep_arguments = { -- install ripgrep!
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          -- '--glob', '!{**/.git/*, **/.metals/*}', --do not search git,metals directory. FIXME: Adding this seems to mess up live grep.
        },
        file_ignore_patterns = {
          --getting this wrong causes telescope.builtin lsp actions to stop working on metals
          "%.git/",
          "%.class",
          "%.semanticdb",
          "%.cache",
          "%.jar",
        },
      },
    })

    telescope.load_extension("ui-select")
    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
  end,
}
