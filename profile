# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$PATH:$HOME/.local/bin"
fi

# Set some defaults
export EDITOR='vim'
export BROWSER='qutebrowser'

# Java
#export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Android
#export ANDROID_SDK_ROOT=/usr/lib/android-sdk
export ANDROID_HOME=$HOME/Android/Sdk

# VS Code
PATH=$PATH:/snap/bin

# golang
#export GOPATH=$HOME/go
#export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Google AppEngine
#CLOUD_SDK_ROOT="${HOME}/.local/google-cloud-sdk/"
#export PYTHONPATH="${PYTHONPATH}:${CLOUD_SDK_ROOT}/platform/google_appengine"
#export PYTHONPATH="${PYTHONPATH}:${CLOUD_SDK_ROOT}/platform/google_appengine/lib/yaml/lib"
#export PATH="${PATH}:${CLOUD_SDK_ROOT}/bin"


# Change BG color (done here primarily for dwm, which doesn't hit ~/.xinitrc
# when logging in?)
xsetroot -solid "#333333"

# Fix Android Studio window behavior (and maybe others?)
export _JAVA_AWT_WM_NONREPARENTING=1
