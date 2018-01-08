setl colorcolumn=130

let g:deoplete#sources.scala = ['buffer', 'omni', 'tag']
let g:deoplete#omni#input_patterns.scala = [ '^import .*', '[^. *\t]\.\w*', '^ *[^ ][a-zA-Z]{1,100}', '\( *_.' ]
let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']
let g:syntastic_scala_checkers = ['fsc']

let g:ycm_collect_identifiers_from_tags_files = 1

au VimEnter,BufRead,BufNewFile *.sc call neoterm#test#libs#add('sbt console')

let ensime_server_v2=1
