#!/bin/bash
#
# Dependencies: xdotool
# @param 1: The username to switch to
#

USERNAME=$1

USER_TTY=`w | grep -e "$USERNAME *tty" | awk 'NR == 1 { print $2 }' | sed "s/tty//"`

if [ "$USER_TTY" == "" ]; then
    gdmflexiserver --new
else
    CHANGE_TTY_KEY_PRESS="ctrl+alt+F$USER_TTY"
    xdotool key $CHANGE_TTY_KEY_PRESS
fi

