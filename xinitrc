gpg-agent --daemon --enable-ssh-support ||:
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources


xprop() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }

xprop "Evdev Wheel Emulation" 1
xprop "Evdev Wheel Emulation Button" 2
xprop "Evdev Wheel Emulation Timeout" 200
xprop "Evdev Wheel Emulation Axes" 6 7 4 5
xprop "Device Accel Constant Deceleration" 0.95

exec i3
