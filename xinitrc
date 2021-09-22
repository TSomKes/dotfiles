
xset b off

# Make xterm notice .Xresources
xrdb -merge ~/.Xresources

# Remap capslock <--> ctrl
xmodmap ~/.Xmodmap

exec dwm

