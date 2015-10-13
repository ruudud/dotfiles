parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

export TERMINAL='urxvt'
export TERM='xterm-256color'
[[ -n "$TMUX" ]] && export TERM='screen-256color'

export HISTTIMEFORMAT="%F %T "
export PS1="\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;31m\][\u@\h] \[\e[0;0m\]\w\n\[\e[0;33;49m\]✈ \[\e[0;0m\]"

export EDITOR=vim

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
[[ -f "$HOME/dotfiles/bash_aliases" ]] && . $HOME/dotfiles/bash_aliases

[[ -f "$HOME/.bashrc-local" ]] && . "$HOME/.bashrc-local"

eval "$(rbenv init -)"

if [[ -f "${HOME}/.gpg-agent-info" ]]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
fi
