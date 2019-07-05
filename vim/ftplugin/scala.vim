let g:scala_sort_across_groups=1
let g:import_sort_settings['scala'] = {
\ 'import_prefix': 'import ',
\   'import_groups': [
\     'java\(x\)\?\.',
\     'scala\.'
\  ]
\}

let g:syntastic_scala_checkers = ['fsc']

let g:ycm_collect_identifiers_from_tags_files = 1
" [error] /Users/jacobbarber/projects/sbt-quickfix/src/main/scala/com/dscleaver/sbt/quickfix/QuickFixAppender.scala:58: value asdf is not a member of String
" [error] one error found
" [error] (Compile / compileIncremental) Compilation failed
set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
set errorformat+=,%W\ %#[warn]\ %#%f:%l:\ %m,%-Z\ %#[warn]\ %p^,%-C\ %#[warn]\ %m
set errorformat+=,%-G%.%#

noremap <silent> <Leader>ff :cf target/quickfix/sbt.quickfix<CR>
noremap <silent> <Leader>fn :cn<CR>

let ensime_server_v2=1

" nnoremap <silent><leader>fd :<C-u>execute 'Ag (def\|class\|trait\|object) <cword>'<cr>
nnoremap <silent><leader>fe :<C-u>execute 'Ag (extends\|with) <cword>'<cr>
nnoremap <silent> <C-]> :<C-u>call SQualifiedTagJump()<CR>
nnoremap <silent><leader>st :call NgCommand("stags", getcwd())<CR>
nnoremap <silent><leader>sf :call NgCommand("scalafmt",  "-i -f " . expand("%:p"))<CR>:e %<CR>
nnoremap <silent><leader>ss :T qsbt<CR>
nnoremap <silent><leader>sq :T testQuick<CR>
nnoremap <silent><leader>si :T it:testQuick<CR>
nnoremap <silent><leader>sc :T compile<CR>

" ~/.vimrc
" Configuration for coc.nvim

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

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Use K for show documentation in preview window
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <space>sd  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>sag  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

