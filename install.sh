#!/bin/bash
PWD=`pwd`
echo $PWD
echo 'Setting up git ctags...\n'

command -v ctags >/dev/null 2>&1 || { echo "Cannot detect ctags. Please make sure ctags is installed and it is on your PATH." >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "Cannot detect git. Please make sure git is installed and it is on your PATH." >&2; exit 1; }


mkdir -p ~/.config/git/templates/hooks
ln -s $PWD/hooks/* ~/.config/git/templates/hooks/

git config --global alias.ctags '!.git/hooks/ctags'
git config --global init.templatedir '~/.config/git/templates'

echo 'git ctags setup successfully'
echo 'Settings up vim...\n'

mkdir -p ~/.vim/autoload 
mkdir -p ~/.vim/plugged
ln -s $PWD/.vimrc ~/.vimrc
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'vim set up successfully'
echo 'setting up neovim...\n'

mkdir -p ~/.config/nvim/autoload 
mkdir -p ~/.config/nvim/plugged
ln -s $PWD/.vimrc ~/.nvimrc
ln -s $PWD/.vimrc ~/.config/nvim/init.vim
curl -LSso ~/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'neovim set up successfully.'

echo 'done.'
