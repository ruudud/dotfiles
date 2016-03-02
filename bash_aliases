alias crash-tunnel='ssh -L 4200:localhost:4243 cum'
# Xrandr
alias xrandr-single='xrandr --auto --output LVDS1'
alias xrandr-double='xrandr --output DP1 --above LVDS1 --auto'

# ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

alias hdmi-sound='pactl set-card-profile 0 output:hdmi-stereo'
alias hdmi-sound-off='pactl set-card-profile 0 output:analog-stereo'

alias docker-ps='docker ps --format "{{.Names}};{{.Image}};{{.Ports}}" | column -ts ";"'
alias docker-ip='docker inspect -f "{{ .NetworkSettings.IPAddress }}"'
alias docker-remove-dangling='docker rmi $(docker images --filter dangling=true --quiet)'
alias dcc='docker-compose'
docker-remote-tags() {
  curl -s https://dr.api.no/v1/repositories/$1/tags | python -m json.tool
}

fh() {
  find . -name "$1" -print
}
