# From https://superuser.com/a/183980
# See also:
# - http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html,
# - https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout 
if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
