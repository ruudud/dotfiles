alias crash-tunnel='ssh -L 4200:localhost:4243 cum'
alias chrome-debug='adb forward tcp:9222 localabstract:chrome_devtools_remote'

# Xrandr
alias xrandr-single='xrandr --output LVDS1 -s 1366x768 --preferred --output VGA1 --off'
alias xrandr-double='xrandr --output LVDS1 -s 1366x768 --pos 0x0 --output VGA1 --right-of LVDS1 --preferred'

# ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

# Current Google Chrome is acting up.
alias chrome-fixed='google-chrome --allow-outdated-plugins --audio-buffer-size=2048 &'
