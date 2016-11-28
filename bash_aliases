# ls aliases
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

alias dps='docker ps --format "{{.Names}};{{.Image}};{{.Ports}}" | column -ts ";"'
alias dip='docker inspect -f "{{ .NetworkSettings.IPAddress }}"'
alias dcc='docker-compose'
alias docker-gc='docker run --rm -v /var/run/docker.sock:/var/run/docker.sock spotify/docker-gc'

fh() {
  find . -name "$1" -print
}
cdd() {
  cd $(dirname "$1")
}
cdgit() {
    cd $(git rev-parse --show-toplevel)
}
