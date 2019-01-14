# ls aliases
alias ll='exa -l'
alias l='exa'

alias cat='bat'
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
agv() {
  vim -c "silent grep $* $(git rev-parse --show-toplevel)" +cw
}
fiv() {
  x="$(sk --bind "ctrl-p:toggle-preview" --ansi --preview="preview.sh -v {}" --preview-window=up:50%:hidden)"
  [[ $? -eq 0 ]] && vim "$x" || true
}
rgv() {
  x="$(sk --bind "ctrl-p:toggle-preview" --ansi -i --cmd-query "$1" -c "rg -i --color=always --line-number \"{}\"" --preview="preview.sh -v {}" --preview-window=up:50%:hidden)"
  [[ $? -eq 0 ]] && vim "$(echo $x|cut -d: -f1)" "+$(echo $x|cut -d: -f2)" || true
}
