let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'haskell': ['hie', '--lsp'],
    \ 'scala': ['coursier', 'launch', '-r', 'bintray:scalameta/maven', 'org.scalameta:metals_2.12:SNAPSHOT', '-M', 'scala.meta.metals.Main']
    \ }
