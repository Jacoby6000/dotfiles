#!/bin/bash
PWD=`pwd`
echo $PWD
echo 'Setting up git ctags...\n'

command -v ctags >/dev/null 2>&1 || { echo "Cannot detect ctags. Please make sure ctags is installed and it is on your PATH." >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "Cannot detect git. Please make sure git is installed and it is on your PATH." >&2; exit 1; }

command -v nvim +q >/dev/null 2>&1 || { echo "Cannot detect neovim. Please make sure neovim is installed and it is on your PATH." >&2; exit 1; }


mkdir -p ~/.config/git/templates/hooks
ln -s $PWD/hooks/* ~/.config/git/templates/hooks/

git config --global alias.ctags '!.git/hooks/ctags'
git config --global init.templatedir '~/.config/git/templates'

echo 'git ctags setup successfully'
echo 'setting up neovim...\n'

mkdir -p ~/.config/nvim/autoload
mkdir -p ~/.config/nvim/plugged
ln -s $PWD/vim/vimrc ~/.nvimrc
ln -s $PWD/vim/vimrc ~/.config/nvim/init.vim
ln -s $PWD/vim/ftplugin ~/.config/nvim/
ln -s $PWD/vim/qol ~/.config/nvim/
ln -s $PWD/vim/plugin-confs ~/.config/nvim/plugin-confs
ln -s ~/.config/nvim ~/.nvim
curl -LSso ~/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'neovim set up successfully.'

echo 'Setting up weechat IRC server'
ln -s $PWD/weechat/irc.conf $HOME/.weechat/irc.conf

#ghc-env does not work on osx :(
#echo 'Setting up ghc-env'
#ln -s $PWD/ghc-env $HOME/.ghc-env

echo 'Installing brittany config'
ln -s $PWD/brittany $HOME/.config/

echo 'Setting up ghci'
ln -s $PWD/.haskeline $HOME/
ln -s $PWD/.ghci $HOME/

echo 'done.'
