# Installation
1. create a symbolic link from this repo's .vimrc to ~/.vimrc (or ~/.config/nvim/init.vim) 
2. Install VimPlug
3. go in to vim and run :PlugInstall
4. install the githooks if you want ctags support via `install.sh`

# ENSIME

If you want to use ensime, be sure to install the ensime sbt plugin:

Add this line to ~/.sbt/0.13/plugins/plugins.sbt. Notice that it's plugins/plugins.sbt, not just plugins.sbt.
```
addSbtPlugin("org.ensime" % "ensime-sbt" % "0.2.0")
```

Then run 
```
sbt gen-ensime
```

Followed by
```
:UpdateRemotePlugins
```

in vim.

from the project root where you want to use ensime
