#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

. $HOME/.Xsession
#exec i3 -V >> ~/.log/i3log-$(date +%F) 2>&1
exec i3
