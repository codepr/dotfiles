#!/bin/bash

################################################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles
# in ~/dotfiles
################################################

# Variables

dir = ~/dotfiles                # dotfiles directory
oldDir = ~/dotfiles_old         # old dotfiles backup directory
files = "zsh/zshrc vim/vimrc vim oh-my-zsh"

# create dotfiles_old in HOMEDIR

echo -n "Creating $oldDir for backup of any existing dotfiles in ~ ..."
mkdir -p $oldDir
echo "done"

# change to the dotfiles directory

echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create
# symlinks from the homedir to any files in the ~/dotfiles directory specified
# in $files

for file in $files; do
    echo "Moving any existing dotfiles from ~ to $oldDir"
    mv ~/.$file $oldDir
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# symlink emacs directory

echo -n "Creating a symlink to from ~/dotfiles/emacs pointing to ~/.emacs.d/ "
ln -s $dir/emacs/ ~/.emacs.d/
echo "done"

# zsh function

install_zsh () {
    # Test to see if zshell is installed. If it is:
    if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
        # Clone my oh-my-zsh repository from GitHub only if it isn't already
        # present
        if [[ ! -d $dir/oh-my-zsh/ ]]; then
            git clone http://github.com/robbyrussell/oh-my-zsh.git
        fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
            chsh -s $(which zsh)
        fi
    else
        # If zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # If the platform is Linux, try an apt-get to install zsh and then
        # recurse
        if [[ $platform == 'Linux' ]]; then
            if [[ -f /etc/redhat-release ]]; then # redhat distro
                sudo yum install zsh
                install_zsh
            fi
            if [[ -f /etc/debian_version ]]; then # debian based distro
                sudo apt-get install zsh
                install_zsh
            fi
            if [[ -f /etc/arch-release ]]; then # arch linux distro
                sudo pacman -S install zsh
                install_zsh
            fi
        fi
    fi
}

install_zsh

# Copy alias.sh from ~/dotfiles/zsh/ to ~/.oh-my-zsh/lib/

cp $dir/zsh/alias.sh ~/.oh-my-zsh/lib/
