let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:hindent_line_length = 120


lua <<EOF
  local ht = require('haskell-tools')
  local buffer = vim.api.nvim_get_current_buf()
  local def_opts = { noremap = true, silent = true, }
  ht.setup {
    hls = {
      on_attach = function(client, bufnr)
        local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
        vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
      end,
    },
  }

  -- Suggested keymaps that do not depend on haskell-language-server:
  local bufnr = vim.api.nvim_get_current_buf()
  -- set buffer = bufnr in ftplugin/haskell.lua
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Toggle a GHCi repl for the current package
  vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
  -- Toggle a GHCi repl for the current buffer
  vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
  end, def_opts)
  vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
EOF


" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

set ts=2
set sts=2
set tw=120
set sw=2
set colorcolumn=120

let g:haskell_indent_if = 4
let g:haskell_indent_case = 2
let g:haskell_indent_let = 2
let g:haskell_indent_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_after_bare_do = 2
let g:haskell_indent_after_bare_in = 2
let g:haskell_indent_after_bare_guard = 2
let g:haskell_indent_case_alternative = 1

let g:cabal_indent_section = 2
