vim.bo.tabstop = 2 
vim.bo.shiftwidth = 2 
vim.bo.expandtab = true
vim.bo.softtabstop = 2


local MapFuncs = require("lib.map_util")
local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()

local bufferOpts = { buffer = bufnr }

MapFuncs.nnoremap("<leader>ea", "Evaluate all code snippets", ht.lsp.buf_eval_all, bufferOpts)
MapFuncs.nnoremap(
  "<leader>hs",
  "Hoogle search the sigunature of the definition under the cursor",
  ht.lsp.buf_eval_all,
  bufferOpts
)
