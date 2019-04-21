#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

alias ls='ls --color=auto'
PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

alias grep="grep --color"
alias vim=nvim
alias pyd="source ~/py3.7/bin/activate"
alias ll="ls -l"
alias la="ls -la"
alias ssh="TERM=xterm ssh"
alias kp="ps -ef | fzf | tr -s ' ' | cut -d' ' -f2 | xargs kill -9"

export HISTSIZE=
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth
export EDITOR=/usr/bin/nvim
export PATH="$HOME/bin:$PATH"

shopt -s checkwinsize


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm/bin:$PATH"

# ssh-agent
# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#     ssh-agent > ~/.ssh-agent-thing
# fi
# if [[ "$SSH_AGENT_PID" == "" ]]; then
#     eval "$(<~/.ssh-agent-thing)"
# fi

pyd

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/andrea/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /home/andrea/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/andrea/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /home/andrea/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
