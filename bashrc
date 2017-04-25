
alias grep='grep --color=auto'
alias ls='ls --color=auto'

export PATH=$PATH:~/code/utilities
#export PATH=$PATH:/usr/lib/google-cloud-sdk/bin

# Brian and Selenium are jerks
export PATH=$PATH:~/chromedriver_install_place

export PYTHONPATH="$PYTHONPATH:/usr/local/google_appengine"
export PYTHONPATH="$PYTHONPATH:/usr/local/google_appengine/lib/yaml/lib"

# Change prompt:  newline, working directory
PS1='\n\w\$ '

# Disable system beep (sets beep length to 0)
setterm blength 0

# Enable auto-completion
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/tsomkes/Desktop/google-cloud-sdk/path.bash.inc' ]; then source '/home/tsomkes/Desktop/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/tsomkes/Desktop/google-cloud-sdk/completion.bash.inc' ]; then source '/home/tsomkes/Desktop/google-cloud-sdk/completion.bash.inc'; fi
