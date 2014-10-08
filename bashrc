if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
colorscheme="$HOME/dotfiles/solarized/base16-solarized.dark-shell.sh"
[[ -f "$colorscheme" ]] && . $colorscheme

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}
export HISTTIMEFORMAT="%F %T "
export PS1="\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;31m\][\u@\h] \[\e[0;0m\]\w\n\[\e[0;33;49m\]✈ \[\e[0;0m\]"

export PATH="$HOME/dotfiles/bin/:$PATH"
export EDITOR=vim

export VIRTUALENVWRAPPER_VIRTUALENV_ARGS="--no-site-packages"
export WORKON_HOME=$HOME/dev/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
[[ -s /usr/local/bin/virtualenvwrapper_lazy.sh ]] && . /usr/local/bin/virtualenvwrapper_lazy.sh

[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

. ~/dotfiles/bash_aliases

[[ -f "$HOME/.bashrc-local" ]] && . "$HOME/.bashrc-local" 

