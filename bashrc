# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"
# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"
# append to history, not overwrite
shopt -s histappend
# Prepend cd to directory names automatically
shopt -s autocd
# Correct spelling errors during tab-completion
shopt -s dirspell
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell
# Export a variable containing a path and you will be able to cd into it
# regardless of the directory you're in
shopt -s cdable_vars
# ..like so:
export dotfiles="$HOME/dotfiles"


parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

export TERMINAL='urxvt'
export TERM='xterm-256color'
[[ -n "$TMUX" ]] && export TERM='screen-256color'

export HISTTIMEFORMAT="%d/%m/%y %T "
export PS1="\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;31m\][\u@\h] \[\e[0;0m\]\w\n\[\e[0;33;49m\]✈ \[\e[0;0m\]"

export EDITOR=vim

# IntelliJ fix
export IBUS_ENABLE_SYNC_MODE=1

export GOPATH="$HOME/dev/go"
export WORKON_HOME="$HOME/dev/python"

[[ -f /etc/bash_completion ]] && . /etc/bash_completion

[[ -f "$HOME/dotfiles/bash_aliases" ]] && . $HOME/dotfiles/bash_aliases

[[ -f "$HOME/.bashrc-local" ]] && . "$HOME/.bashrc-local"
