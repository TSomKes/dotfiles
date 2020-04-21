# History options
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# No beeps
unsetopt beep

# Vim-mode keybindings
bindkey -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tsomkes/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt:  blue, newline + pwd (w/ ~ substitution) + % or #
# (Blue + newline: better visual separation)
PROMPT=$'\n'"%F{25}%~%f%# "

# Aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Turn off the auto-suggest-with-tab, behave more like bash (suggest, but make
# you type)
setopt noautomenu
setopt nomenucomplete

# tmux is irritating me with shared history between panes.  This answer
# (https://stackoverflow.com/a/32060011) leads me to believe it's the fault of
# oh-my-zsh.  The fix:
#setopt nosharehistory

# Should this be done elsewhere?
export EDITOR='vim'
