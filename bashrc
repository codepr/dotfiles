#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -ll'
alias la='ls -la'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# PS1='[\u@\h \W]\$ '


PS1="[\u@\h \W]\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1
if [ -z "$DISPLAY" -a $XDG_VTNR -eq 1 ]; then
    ssh-agent startx
fi

export HINTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export EDITOR=/usr/bin/vi

alias grep='grep --color=tty -d skip'

