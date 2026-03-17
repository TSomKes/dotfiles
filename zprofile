# Emulate sh to load ~/.profile
# (via https://superuser.com/questions/187639/zsh-not-hitting-profile)
emulate sh -c '. ~/.profile'

# Poor man's DM
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    echo "Choose your session (defaulting to dwm in 3s):"
    echo "1) dwm"
    echo "2) LXDE (lies, DNE)"
    echo "3) lxqt"
    echo "4) tty"
    read -t 3 -n 1 session  # 3 seconds, 1 keypress

    case $session in
        2) exec startx /usr/bin/startlxde ;;
        3) exec startx /usr/bin/startlxqt ;;
        4) ;; # no exec, drop into tty session
        *) exec startx ;; # Defaults to your .xinitrc (dwm)
    esac
fi
