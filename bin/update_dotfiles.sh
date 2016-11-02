#!/bin/bash

################################################
# update_dotfiles.sh This script watchout for changes on system dotfiles and
# overwrite ~/dotfiles folder entries accordingly, pushing it into remote
# repository
################################################

# Variables

declare -A files

# directories and files to check

files[~/.emacs.d/init.el]=~/dotfiles/emacs/init.el
files[~/.emacs.d/conf/]=~/dotfiles/emacs/conf/
files[~/.vim/vimrc]=~/dotfiles/vim/vimrc
files[~/.tmux.conf]=~/dotfiles/tmux/tmux.conf
files[~/.zshrc]=~/dotfiles/zsh/zshrc
files[~/.oh-my-zsh/lib/alias.sh]=~/dotfiles/zsh/alias.sh
files[~/.eclimrc]=~/dotfiles/eclim/eclimrc
# changes flag
change=false

for path in "${!files[@]}"; do
    if [ "$(diff -r $path ${files[$path]})" != "" ]; then
        if [[ -d $path ]]; then
            cp -r $path/* ${files[$path]}
        else
            cp -r $path ${files[$path]}
        fi
        change=true
    fi
done

if [ "$change" = true ]; then
    echo "There was some changes in dotfiles, commiting.."
    # moving into ~/dotfiles directory
    cd ~/dotfiles
    git add .
    echo "Insert commit message: "
    read commit_message
    git commit -am "$commit_message"
    git push origin master
fi
