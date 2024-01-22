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
venv-create2() {
  cdgit
  virtualenv --python=python2 .env
  source .env/bin/activate
  cd -
}
venv-create() {
  cdgit
  virtualenv --python=python3 .env
  source .env/bin/activate
  cd -
}
venv-activate() {
  cdgit
  source .env/bin/activate
  cd -
}

xrandr-single() {
  for disp in $(xrandr | awk '/connected/ {print $1}' | grep -v eDP); do
    xrandr --output "$disp" --off
  done
  xrandr --auto --output eDP
}
xrandr-double() {
  # Maybe better to grep -v eDP
  extconnected=$(xrandr | awk '/ connected/ {print $1}' | tail -n1)
  xrandr --output "$extconnected" --above eDP --auto
  feh --bg-fill ~/Pictures/bg.png
}

xrandr-toggle() {
  amountconnected=$(xrandr | grep ' connected' | wc -l)
  if (( $amountconnected == 2 )); then
    xrandr-double
  else
    xrandr-single
  fi
}
