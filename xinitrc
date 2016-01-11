envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
    eval "$(cat "$envfile")"
else
    eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
fi
export GPG_AGENT_INFO  # the env file does not contain the export statement
export SSH_AUTH_SOCK   # enable gpg-agent for ssh

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources


xprop() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }

xprop "Evdev Wheel Emulation" 1
xprop "Evdev Wheel Emulation Button" 2
xprop "Evdev Wheel Emulation Timeout" 200
xprop "Evdev Wheel Emulation Axes" 6 7 4 5
xprop "Device Accel Constant Deceleration" 0.95

exec i3
