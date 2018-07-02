let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:hindent_line_length = 120

nnoremap <LEADER>sf :call LanguageClient_textDocument_formatting()<CR>
vnoremap <LEADER>sf :call LanguageClient_textDocument_rangeFormatting()<CR>
nnoremap <LEADER>sr :call LanguageClient_textDocument_rename()<CR>
nnoremap <LEADER>su :call LanguageClient_textDocument_references()<CR>
nnoremap <LEADER>sh :call LanguageClient_textDocument_hover()<CR>
nnoremap <LEADER>fd :call LanguageClient_textDocument_definition()<CR>
nnoremap <LEADER>ss :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <LEADER>sa :call LanguageClient_textDocument_codeAction()<CR>


set ts=2
set sts=2
set tw=2
set colorcolumn=130

let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 1
let g:haskell_indent_after_bare_where = 1
let g:haskell_indent_after_bare_do = 2
let g:haskell_indent_after_bare_in = 2
let g:haskell_indent_after_bare_guard = 2
let g:haskell_indent_case_alternative = 1

let g:cabal_indent_section = 2

let g:import_sort_settings['haskell'] = {
\  'import_prefix': 'import \(qualified\)\? *',
\  'import_groups': [
\    'System.',
\    '\(Control\)\|\(Data\)\|\(Text\).',
\    'Test'
\  ]
\}
