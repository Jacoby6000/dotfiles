" imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
" imap <silent><script><expr> <C-J> :Copilot panel<CR>
" imap <C-.> <Plug>(copilot-next)
" imap <C-,> <Plug>(copilot-previous)

" let g:copilot_no_tab_map = v:true

lua << EOF
  require("copilot").setup({
    panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<C-J>"
        },
        layout = {
          position = "bottom", -- | top | left | right
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = false,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = "<C-j>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C-/>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 16.x
      server_opts_overrides = {},
  })
  require("copilot_cmp").setup({
    suggestion = { enabled = false },
    panel = { enabled = false }
  })
EOF

