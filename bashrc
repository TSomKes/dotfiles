alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias diffz='diff --width=$(tput cols)'
alias diff=colordiff

export HISTCONTROL=ignoredups

# Change prompt:  newline, working directory
PS1='\n\w\$ '

# Disable system beep (sets beep length to 0)
setterm blength 0

# Enable auto-completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

alias dropbox=/usr/local/bin/dropbox.py
alias vim=nvim

# vi keybindings
set -o vi

