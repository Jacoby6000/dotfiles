autocmd BufNewFile,BufRead *.json?*  setfiletype json
autocmd BufNewFile,BufRead *.json    setfiletype json

autocmd BufNewFile,BufRead *.scala   setfiletype scala
autocmd BufNewFile,BufRead *.sbt     setfiletype scala
autocmd BufNewFile,BufRead *.sc      setfiletype scala
autocmd BufNewFile,BufRead *.ws      setfiletype scala

autocmd BufNewFile,BufRead *.simba   setfiletype pascal

autocmd BufNewFile,BufRead *.hs      setfiletype haskell

autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy

autocmd BufNewFile,BufRead *.tf setfiletype tf
autocmd BufNewFile,BufRead *.tfvars setfiletype tf
