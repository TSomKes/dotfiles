# History options
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# No beeps
unsetopt beep

# Vim-mode keybindings
#bindkey -v
bindkey -e

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tsomkes/.zshrc'

# for poetry tab-completion
fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt:  bold, blue, newline + pwd (2 levels, w/ ~ substitution) + % or #
# (Blue + newline: better visual separation)
PROMPT=$'\n'"%B%F{25}%2~%f%b %# "

# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# `vagrant ssh` was gross because it didn't have a TERM value I wanted.
# After some searching for a solution, I landed on this gross approach.
alias vsshz='TERM=xterm-256color vagrant ssh'

# Turn off the auto-suggest-with-tab, behave more like bash (suggest, but make
# you type)
setopt noautomenu
setopt nomenucomplete

# Case-insensitive auto-completion
# (via http://zsh.sourceforge.net/Guide/zshguide06.html#l171)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# tmux is irritating me with shared history between panes.  This answer
# (https://stackoverflow.com/a/32060011) leads me to believe it's the fault of
# oh-my-zsh.  The fix:
#setopt nosharehistory
