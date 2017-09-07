#
# ~/.bashrc
#
[ -n "$XTERM_VERSION" ] && transset-df 0.95 --id "$WINDOWID" >/dev/null
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -ll'
alias la='ls -la'
alias kvim='nvim -u ~/.kern-vimrc'
alias cvim='nvim -u ~/.cvimrc'
alias vim='nvim'
alias vi='nvim'


function check_git_status {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
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

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export EDITOR=/usr/bin/nvim
export ELEMIZE_DB_HOST=172.17.0.2
export DOCKER_ID_USER="abaldan"

alias grep='grep --color=tty -d skip'
alias pve='source ~/elemize/elemize-backend/bin/activate'


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!__pycache__/*" --glob "!.pyc"'

shopt -s checkwinsize
