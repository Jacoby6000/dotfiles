#!/bin/bash
command -v ctags >/dev/null 2>&1 || { echo "Cannot detect ctags. Please make sure ctags is installed and it is on your PATH." >&2; exit 1; }
command -v git >/dev/null 2>&1 || { echo "Cannot detect git. Please make sure git is installed and it is on your PATH." >&2; exit 1; }

PWD=`pwd`

mkdir -p ~/.config/git/templates/hooks
ln -s $PWD/hooks/* ~/.config/git/templates/hooks/

git config --global alias.ctags '!.git/hooks/ctags'
git config --global init.templatedir '~/.config/git/templates'
