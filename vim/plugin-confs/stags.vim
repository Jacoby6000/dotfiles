function! SQualifiedTagJump() abort
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
