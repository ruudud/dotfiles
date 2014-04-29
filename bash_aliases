alias crash-tunnel='ssh -L 4200:localhost:4243 cum'
alias chrome-debug='adb forward tcp:9222 localabstract:chrome_devtools_remote'

# Xrandr
alias xrandr-single='xrandr --auto --output LVDS1 -s 1366x768 --preferred --output VGA1 --off'
alias xrandr-double='xrandr --output LVDS1 -s 1366x768 --pos 0x0 --output VGA1 -s 1280x720 --right-of LVDS1 --preferred'
alias xrandr-lee='xrandr --output HDMI1 -s 1920x1080 --output VGA1 -s 800x600 --left-of HDMI1 --output LVDS1 --off'

# ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

alias hdmi-sound='pactl set-card-profile 0 output:hdmi-stereo'
alias hdmi-sound-off='pactl set-card-profile 0 output:analog-stereo'

