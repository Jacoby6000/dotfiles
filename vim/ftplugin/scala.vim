setl colorcolumn=130

let g:deoplete#sources.scala = ['buffer', 'omni', 'tag']
let g:deoplete#omni#input_patterns.scala = [ '^import .*', '[^. *\t]\.\w*', '^ *[^ ][a-zA-Z]{1,100}', '\( *_.' ]
let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']
let g:syntastic_scala_checkers = ['fsc']

let g:ycm_collect_identifiers_from_tags_files = 1

au VimEnter,BufRead,BufNewFile *.sc call neoterm#test#libs#add('sbt console')

let ensime_server_v2=1

function! QualifiedTagJump() abort
  let l:plain_tag = expand("<cword>")
  let l:orig_keyword = &iskeyword
  set iskeyword+=\.
  let l:word = expand("<cword>")
  let &iskeyword = l:orig_keyword

  let l:splitted = split(l:word, '\.')
  let l:acc = []
  for wo in l:splitted
    let l:acc = add(l:acc, wo)
    if wo ==# l:plain_tag
      break
    endif
  endfor

  let l:combined = join(l:acc, ".")
  try
    execute "ta " . l:combined
  catch /.*E426.*/ " Tag not found
    execute "ta " . l:plain_tag
  endtry
endfunction

nnoremap <silent> <C-]> :<C-u>call QualifiedTagJump()<CR>
