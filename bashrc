parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

export TERMINAL='urxvt'
export TERM='xterm-256color'
[[ -n "$TMUX" ]] && export TERM='screen-256color'

export HISTTIMEFORMAT="%F %T "
export PS1="\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;31m\][\u@\h] \[\e[0;0m\]\w\n\[\e[0;33;49m\]✈ \[\e[0;0m\]"

export EDITOR=vim

# IntelliJ fix
export IBUS_ENABLE_SYNC_MODE=1

export GOPATH="$HOME/dev/go"

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

[[ -f "$HOME/dotfiles/bash_aliases" ]] && . $HOME/dotfiles/bash_aliases

[[ -f "$HOME/.bashrc-local" ]] && . "$HOME/.bashrc-local"
