#!/bin/bash
DISPLAY=:0
SCREENSHOTDIR=~/Pictures
NOW=`date +%Y-%d-%m-%H:%M:%S`
FILENAME="${SCREENSHOTDIR}/screenshot-${NOW}.png"

cleanup() {
    echo -e "\n*** Aborting ***"
    rm $FILENAME
    exit 0
}

# Run the cleanup function if the user press CTRL-C
trap cleanup SIGINT

ACTIVEWINDOW=`xprop -root | grep "_NET_ACTIVE_WINDOW(WINDOW)" | awk '{print $5}'`

# Make the dump
xwd -silent -id $ACTIVEWINDOW | xwdtopnm | pnmtopng > $FILENAME

# Create a symlink for easier lookup
ln -sfn $FILENAME $SCREENSHOTDIR/latest_screenshot.png
