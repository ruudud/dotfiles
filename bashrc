if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}
if [ "$TERM" != "screen-256color" ]; then
    export TERM=xterm-256color
fi
export HISTTIMEFORMAT="%F %T "
export PS1="\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;31m\][\u@\h] \[\e[0;0m\]\w\n\[\e[0;33;49m\]✈ \[\e[0;0m\]"
export EDITOR=vim
export PATH="$HOME/dotfiles/bin/:$PATH"

export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--no-site-packages"
export WORKON_HOME=$HOME/dev/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
[[ -s /usr/local/bin/virtualenvwrapper_lazy.sh ]] && . /usr/local/bin/virtualenvwrapper_lazy.sh

[[ -s "/home/$USER/.nvm/nvm.sh" ]] && . "/home/$USER/.nvm/nvm.sh"

eval "$(grunt --completion=bash)"

. ~/dotfiles/bash_aliases
