#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Source VTE settings
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
	source /etc/profile.d/vte.sh
fi

# editor settings
export EDITOR=vim
export VISUAL=$EDITOR

# add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# homestead
function homestead() {
    ( cd ~/work/tml/homestead && vagrant $* )
}

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# reverse Search
bindkey -v
bindkey '^R' history-incremental-search-backward

# local binaries
export PATH="$PATH:$HOME/.bin"

# 256 color tmux support
alias tmux="tmux -2"

# ubuntu snap
export PATH="$PATH:/snap/bin"

# golang
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# pip (System)
export PATH="$PATH:$HOME/.local/bin"

# aliases
alias open="xdg-open"
alias todos="ag -Q 'TODO:' --ignore-dir public"
alias mux="tmuxinator"
alias notes="yokadi"
