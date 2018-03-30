setl colorcolumn=130

let g:scala_sort_across_groups=1
let g:syntastic_scala_checkers = ['fsc']

let g:ycm_collect_identifiers_from_tags_files = 1

set errorformat=%E\ %#[error]\ %#%f:%l:%c:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
set errorformat+=,%W\ %#[warn]\ %#%f:%l:%c:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
set errorformat+=,%-G%.%#
noremap <silent> <Leader>ff :cf .git/sbt.quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>

let ensime_server_v2=1

nnoremap <silent><leader>f /\(def\\|val\\|class\\|trait\\|object\) \<<C-r><C-w>\>/I<cr>
nnoremap <silent><leader>fd :<C-u>execute 'Ag (def\|class\|trait\|object) <cword>'<cr>
nnoremap <silent><leader>fe :<C-u>execute 'Ag (extends\|with) <cword>'<cr>
nnoremap <silent> <C-]> :<C-u>call SQualifiedTagJump()<CR>
nnoremap <silent><leader>st :!stags ./<CR>
nnoremap <silent><leader>sf :!scalafmt -i -f %<CR>
nnoremap <silent><leader>ss :T qsbt<CR>
nnoremap <silent><leader>sq :T testQuick<CR>
nnoremap <silent><leader>si :T it:testQuick<CR>
nnoremap <silent><leader>sc :T compile<CR>

function! GetPackageForFile()
    let regexes = [
                \   [ '/src/main/scala',      '/src/main/scala' ],
                \   [ '/src/test/scala',      '/src/test/scala' ],
                \   [ '/src/it/scala',        '/src/it/scala' ],
                \   [ '/src/fun/scala',       '/src/fun/scala' ],
                \   [ '/src/multi-jvm/scala', '/src/multi-jvm/scala' ],
                \   [ '/app/model/scala',     '/app/model/scala' ],
                \   [ '/app/controllers',     '/app' ],
                \   [ '/app/com',             '/app' ],
                \   [ '/test/com',            '/test' ],
                \   [ '/test/scala',          '/test/scala' ]
                \ ]
    return _GetPackageForFile(regexes)
endfunction

