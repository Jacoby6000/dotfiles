# Key binds
* Ctrl+n to open/close file tree
* Ctrl+p to open ctrlp, the fuzzy file finder. May take some time to index upon first run of larger projects
* Arrow keys have been unbound to prevent impure bastardized use of vim.

# Installation
1. copy .vimrc to ~/.vimrc
2. Install vundle with ```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim```
3. If you've upgraded to el-capitan, see step 3a below
4. install websocket client with ```sudo pip install websocket-client --upgrade```
5. go in to vim and, in command mode, type :PluginInstall
6. ???
7. Profit

# 3a. The woes of el-capitan

El capitan seems to have caused some issues with brew/pip. Be sure you have write access to /usr/local/lib, and then run these to fix it: (xcode must be installed)
```
ls -1 /usr/local/Library/LinkedKegs | while read line; do
    echo $line
    brew unlink $line
    brew link --horse $line
done
sudo xcode-select --install
sudo chown -R $(whoami):admin /usr/local
brew update && brew reinstall python
pip install --upgrade pip
sudo pip uninstall websocket-client
```
