export GTK_IM_MODULE="gtk-im-context-simple"
export QT_IM_MODULE="simple"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.xinitrc-local ]] && source .xinitrc-local

exec i3
