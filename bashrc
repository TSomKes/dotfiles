
alias grep='grep --color=auto'
alias ls='ls --color=auto'

export PATH=$PATH:~/code/utilities

# Change prompt:  newline, working directory
PS1='\n\w\$ '

# Disable system beep (sets beep length to 0)
setterm blength 0

# Enable auto-completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
