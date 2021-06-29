let g:ag_working_path_mode="r"
let g:ag_prg="/usr/bin/ag --column --path-to-ignore ~/.agignore"

nnoremap <silent><leader>fw :Ag <cword><CR>
