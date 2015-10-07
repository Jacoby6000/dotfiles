# installation
1. copy .vimrc to ~/.vimrc
2. Install vundle with ```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim```
3. If you've not yet upgraded to el-capitan, go to 5
4. Clean up your brew/pip/python with
```
sudo xcode-select --install
sudo chown -R $(whoami):admin /usr/local
brew update && brew reinstall python
pip install --upgrade pip
sudo pip uninstall websocket-client
```
5. install websocket client with ```sudo pip install websocket-client --upgrade```
6. go in to vim and, in command mode, type :PluginInstall
7. ???
8. Profit
