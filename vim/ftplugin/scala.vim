exe 'source' '~/.config/nvim/coc-settings.vim'

let g:scala_sort_across_groups=1
let g:import_sort_settings['scala'] = {
\ 'import_prefix': 'import ',
\ 'import_groups': [
\   'java\(x\)\?\.',
\   'scala\.'
\  ]
\}

" let g:syntastic_scala_checkers = ['fsc']

" let g:ycm_collect_identifiers_from_tags_files = 1
" [error] /Users/jacobbarber/projects/sbt-quickfix/src/main/scala/com/dscleaver/sbt/quickfix/QuickFixAppender.scala:58: value asdf is not a member of String
" [error] one error found
" [error] (Compile / compileIncremental) Compilation failed
set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
set errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
set errorformat+=,%-G%.%#

noremap <silent> <Leader>ff :cf target/quickfix/sbt.quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>

" let ensime_server_v2=1
" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>
