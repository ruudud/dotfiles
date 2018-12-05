export GTK_IM_MODULE="gtk-im-context-simple"
export QT_IM_MODULE="simple"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

# Needed to get notify-send to work with dunst
systemctl --user import-environment DISPLAY

# Set desktop background
feh --bg-fill ~/Pictures/bg.png

# lock screen after inactivity, but disable on fullscreen
xautolock -time 5 -locker 'i3lock -c 141414' &
~/dotfiles/bin/lights-on -o 'xautolock -enable' -f 'xautolock -disable' &

[[ -f ~/dotfiles/bin/toggle-touchpad ]] && ~/dotfiles/bin/toggle-touchpad

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.xinitrc-local ]] && source ~/.xinitrc-local

exec i3
