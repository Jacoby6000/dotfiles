#!/bin/bash
PWD=`pwd`
echo $PWD
echo 'Setting up git ctags...\n'

command -v ctags >/dev/null 2>&1 || { echo "Cannot detect ctags. Please make sure ctags is installed and it is on your PATH." >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "Cannot detect git. Please make sure git is installed and it is on your PATH." >&2; exit 1; }

command -v nvim +q >/dev/null 2>&1 || { echo "Cannot detect neovim. Please make sure neovim is installed and it is on your PATH." >&2; exit 1; }


mkdir -p $HOME/.config/git/templates/hooks
ln -s $PWD/hooks/* $HOME/.config/git/templates/hooks/

git config --global alias.ctags '!.git/hooks/ctags'
git config --global init.templatedir '$HOME/.config/git/templates'
git config --global alias.lg 'log --pretty=format:"%Cred%h%Creset -%Creset %s %Cgreen(%cr) %C(bold yellow)<%an>%Creset %d"'

echo 'git ctags setup successfully'
echo 'setting up neovim...\n'

mkdir -p $HOME/.config/nvim/autoload
mkdir -p $HOME/.config/nvim/plugged
ln -s $PWD/vim/vimrc $HOME/.nvimrc
ln -s $PWD/vim/vimrc $HOME/.config/nvim/init.vim
ln -s $PWD/vim/ftplugin $HOME/.config/nvim/
ln -s $PWD/vim/qol $HOME/.config/nvim/
ln -s $PWD/vim/plugin-confs $HOME/.config/nvim/plugin-confs
ln -s $HOME/.config/nvim $HOME/.nvim
curl -LSso $HOME/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
