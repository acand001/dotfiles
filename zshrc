export ZSH_TMUX_AUTOSTART=true
# Load Antigen
source ~/.antigen.zsh

#
# Antigen Bundles
#
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

# Python Plugins
antigen bundle pip
antigen bundle python
antigen bundle virtualenv
antigen bundle tmux

UNAME=`uname`
if [[ $UNAME == 'Darwin' ]]; then
	antigen bundle brew
	antigen bundle brew-cask
	antigen bundle gem
	antigen bundle osx
fi

antigen use oh-my-zsh
source ~/.shell_prompt.sh

antigen apply

export EDITOR=/usr/local/bin/vim
alias tmux="TERM=screen-256color-bce tmux"
