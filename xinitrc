#!/usr/bin/env sh

xset b off

# Make xterm notice .Xresources
xrdb -merge ~/.Xresources

exec dwm
