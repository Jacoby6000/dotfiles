autocmd BufNewFile,BufRead *.json?*  setfiletype json
autocmd BufNewFile,BufRead *.json    setfiletype json

autocmd BufNewFile,BufRead *.scala   setfiletype scala
autocmd BufNewFile,BufRead *.sbt     setfiletype scala
autocmd BufNewFile,BufRead *.sc      setfiletype scala
autocmd BufNewFile,BufRead *.ws      setfiletype scala

autocmd BufNewFile,BufRead *.simba   setfiletype pascal

autocmd BufNewFile,BufRead *.hs      setfiletype haskell

autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy


augroup lsp
  au!
  au FileType scala,sbt setlocal omnifunc=v:lua.vim.lsp.omnifunc
  au FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)
augroup end
