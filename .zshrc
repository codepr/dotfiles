[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/Users/andrea/.mix/escripts:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# iex permanent history
export ERL_AFLAGS="-kernel shell_history enabled"

function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo '- ('$branch')'
  fi
}

export HISTSIZE=
export HISTFILESIZE=50000
export HISTCONTROL=ignoreboth

# Enable substitution in the prompt.
setopt prompt_subst

# Config for prompt. PS1 synonym.
prompt='%2/ $(git_branch_name) > '

#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git svn
## This line obtains information from the vcs.
#zstyle ':vcs_info:git*' formats "- (%b) "
#precmd() {
#    vcs_info
#}
#
## Enable substitution in the prompt.
#setopt prompt_subst
#
## Config for the prompt. PS1 synonym.
#prompt='%2/ ${vcs_info_msg_0_}> '

alias python=python3
alias pip=pip3
alias utcnow="python -c 'import time;print(time.time())'"
alias vi=nvim
alias ls='ls --color'
alias ll='ls -l --color'
alias la='ls -la --color'
alias v=vi

alias dp="DUFFEL_LINK_ENABLE_PROXY=true DUFFEL_LINK_SKIP_SSL_VERIFY=true mix phx.server"
alias dt="kubectl -n monitoring port-forward svc/squid 3128:3128"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

