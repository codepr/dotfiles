Dotfiles
========

# Install

### Setup a convenient alias

```sh
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
source .bashrc
```

### Checkout dotfiles

```sh
dotfiles checkout
```
Be careful with any dotfile to be kept or removed if not needed (e.g. existing `.bashrc` etc)

Optionally set `status.ShowUntrackedFiles no` to reduce the noise when running `status` command

```sh
dotfiles config --local status.ShowUntrackedFiles no
```

This will set up a git repository, you can use all the common `git` command from now on, `.cfg` will store the `.git` tracking folder.
