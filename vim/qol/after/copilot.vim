let g:copilot_no_tab_map = true

imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-J> :Copilot panel<CR>
imap <C-.> <Plug>(copilot-next)
imap <C-,> <Plug>(copilot-previous)

