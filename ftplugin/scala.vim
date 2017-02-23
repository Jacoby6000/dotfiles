setl colorcolumn=130

let g:deoplete#sources.scala = ['buffer', 'omni', 'tag']
let g:deoplete#omni#input_patterns.scala = [ '^import .*', '[^. *\t]\.\w*', '^ *[^ ][a-zA-Z]{1,100}', '\( *_.' ]
let g:syntastic_scala_scalastyle_jar = '/usr/local/Cellar/scalastyle/0.8.0/libexec/scalastyle_2.11-0.8.0-batch.jar'
let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']
let g:syntastic_scala_checkers = ['fsc', 'scalastyle']

let g:neoterm_repl_command = "sbt console"
let g:ycm_collect_identifiers_from_tags_files = 1

au VimEnter,BufRead,BufNewFile *.sc call neoterm#test#libs#add('sbt console')
