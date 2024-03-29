# History options
export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000
setopt HIST_IGNORE_DUPS

# No beeps
unsetopt beep

# Vim-mode keybindings
bindkey -e      # -v

# The following lines were added by compinstall
zstyle :compinstall filename '/home/tsomkes/.zshrc'

# for poetry tab-completion
fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt:  bold, blue, newline + pwd (2 levels, w/ ~ substitution) + % or #
# (Blue + newline: better visual separation)
export PROMPT=$'\n'"%B%F{25}%2~%f%b %# "

# Aliases
alias cat=batcat
alias top=btop
alias tree=tre
alias vim=nvim

alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias lynx='lynx -vikeys'

alias fixcaps='setxkbmap -option "ctrl:swapcaps"'   # gross hack :(
alias steamlink='flatpak run com.valvesoftware.SteamLink'
alias tmuxz='./tmux-start.sh'
alias vact='. ./env/bin/activate'

# PA aliases
alias aside='capture-aside'
alias circleback='vim ~/notes/pa/asides*'
alias doing='capture-doing'
alias mygod='tail ~/notes/pa/doing*' 

# `vagrant ssh` was gross because it didn't have a TERM value I wanted.
# After some searching for a solution, I landed on this gross approach.
alias vsshz='TERM=xterm-256color vagrant ssh'

# Display to second bigger monitor (shrinking display of lappy to match res.)
alias disp2='xrandr --fb 1920x1080 \
    --output LVDS-1 --mode 1600x900 --scale-from 1920x1080 \
    --output HDMI-1 --mode 1920x1080 --scale 1x1 --same-as LVDS-1'
# Back to original display on lappy, turn off output to 2nd montior
alias disp1='xrandr --fb 1600x900 \
    --output LVDS-1 --scale 1x1 \
    --output HDMI-1 --off'

# Turn off the auto-suggest-with-tab, behave more like bash (suggest, but make
# you type)
setopt noautomenu
setopt nomenucomplete

# Case-insensitive auto-completion
# (via http://zsh.sourceforge.net/Guide/zshguide06.html#l171)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Make nix use zsh
source "$HOME/3rd-party-code/zsh-nix-shell/nix-shell.plugin.zsh"

# Display whether we're in nix-shell, right-hand side, courtesy of:
# - https://github.com/chisui/zsh-nix-shell#environment-info
if [ -n "${IN_NIX_SHELL}" ]; then
    if [ -n "${NIX_TAG}" ]; then
        export RPS1="%B%F{yellow}(nix: $NIX_TAG)%f"
    else
        export RPS1="%B%F{yellow}(nix)%f"
    fi
fi
