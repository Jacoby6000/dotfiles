set ts=2
set sts=2
set tw=2
set colorcolumn=130

let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_indent_disable = 1
let g:hindent_line_length = 120

nnoremap <LEADER>sf :call LanguageClient_textDocument_formatting()<CR>
nnoremap <LEADER>sr :call LanguageClient_textDocument_rename()<CR>
nnoremap <LEADER>sh :call LanguageClient_textDocument_hover()<CR>
nnoremap <LEADER>fd :call LanguageClient_textDocument_definition()<CR>
nnoremap <LEADER>ss :call LanguageClient_textDocument_symbol()<CR>
nnoremap <LEADER>af :call LanguageClient_textDocument_codeAction()<CR>
