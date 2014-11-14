# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi



if [ -n "$DISPLAY" -a "$TERM" == "xterm"  ]; then
        export TERM=xterm-256color
fi

color_prompt=yes

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -h --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


xmodmap ~/.xmodmaprc

Color_Off="\033[0m"
Red="\033[0;31m"
Green="\033[0;32m"
Purple="\033[0;35m"

####-Bold-####
BRed="\033[1;31m"
BPurple="\033[1;35m"

# Status of last command (for prompt)
function __stat() { 
    if [ $? -eq 0 ]; then 
        echo -en "$Green[✔]$Color_Off" 
    else 
        echo -en "$Red[✘]$Color_Off" 
    fi 
}

# Display the branch name of git repository
# Green -> clean
# purple -> untracked files
# red -> files to commit
function __git_prompt() {
 
    local git_status="`git status -unormal 2>&1`"
 
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local Color_On=$Green
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local Color_On=$Purple
        else
            local Color_On=$Red
        fi
 
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
        else
            # Detached HEAD. (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD`)"
        fi
 
        echo -ne "$Color_On[$branch]$Color_Off "
    fi
}

PS1=""
# command status (shows check-mark or red x if last command failed)
PS1+='$(__stat) '$Color_Off
 
# debian chroot stuff (take it or leave it)
PS1+="${debian_chroot:+($debian_chroot)}"
 
# basic information (user@host:path)
PS1+="$BRed\u$Color_Off@$BRed\h$Color_Off:$BPurple\w$Color_Off "
 
# add git display to prompt
PS1+='$(__git_prompt)'$Color_Off
 
# prompt $ or # for root
PS1+="\n \$ "
export PS1

eval `dircolors ~/.dir_colors`

# Added for Extraction
extract () {
   if [ -f $1 ] ; then
        case $1 in
              *.tar.bz2)     tar xvjf $1    ;;
              *.tar.gz)      tar xvzf $1    ;;
              *.tar.xz)      tar xvjf $1     ;;
              *.bz2)         bunzip2 $1     ;;
              *.rar)         rar x $1       ;;
              *.gz)          gunzip $1      ;;
              *.tar)         tar xvf $1     ;;
              *.tbz2)        tar xvjf $1    ;;
              *.zip)         unzip $1       ;;
              *.Z)           uncompress $1  ;;
              *.7z)          7z x $1        ;;
              *)             echo "don't know how to extract '%1'..."
          esac
        else
          echo "'$1' is not a valid file!"
        fi
}

