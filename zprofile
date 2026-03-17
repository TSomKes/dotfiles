# Emulate sh to load ~/.profile
# (via https://superuser.com/questions/187639/zsh-not-hitting-profile)
emulate sh -c '. ~/.profile'

# Poor man's DM
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    echo "Choose your session (defaulting to dwm in 5s):"
    echo "1) dwm"
    echo "2) lxqt"
    echo "3) tty"
    read -t 5 session # 5 seconds

    case $session in
        2) exec startx /usr/bin/startlxqt ;;
        3) ;; # no exec, drop into tty session
        *) exec startx ;; # Default to .xinitrc (dwm)
    esac
fi
