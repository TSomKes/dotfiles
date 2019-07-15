# From http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#if [ -f ~/.bashrc ]; then
   #source ~/.bashrc
#fi


# From https://superuser.com/a/183980
# (See also http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html)
if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac
