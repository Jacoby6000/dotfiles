#!/bin/bash
PWD=`pwd`

-- make function for checking if command exists
function ensure_command_exists() {
    command -v $1 >/dev/null 2>&1 || { echo "❌ Cannot detect $1. Please make sure $1 is installed and it is on your PATH." >&2; exit 1; }
    echo "  ✅ $1"
}

function create_git_alias() {
    git config --global alias.$1 $2
    echo "  ✅ git $1 -> git $2"
}

function symlink() {
    if [ -e $2 ]; then
        echo "  ❌ $2 already exists. Skipping..."
    else
        ln -s $1 $2
        echo "  ✅ $1 -> $2"
    fi
}


echo "Checking for required binaries..."
ensure_command_exists git
ensure_command_exists nvim
ensure_command_exists stylua
ensure_command_exists asdfkljahsdf
echo ""

echo "Setting up git aliases..."
create_git_alias 's' 'status'
create_git_alias 'c' 'commit'
create_git_alias 'lg' 'log --pretty=format:"%Cred%h%Creset -%Creset %s %Cgreen(%cr) %C(bold yellow)<%an>%Creset %d'
echo ""

echo "Setting up neovim..."
symlink $PWD/neovim $HOME/.config/nvim
symlink $PWD/neovim $HOME/.nvim
echo ""

echo 'done.'
