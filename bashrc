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

# For interactive shells only
if [[ -t 1 ]]; then
  # Perform file completion in a case insensitive fashion
  bind "set completion-ignore-case on" 2>/dev/null
  # Display matches for ambiguous patterns at first tab press
  bind "set show-all-if-ambiguous on" 2>/dev/null
  # No need to disable flow
  stty -ixon
fi

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1] /'
}

export BROWSER='google-chrome-stable'
export EDITOR='vim'
export TERMINAL='alacritty'
export TERM='xterm-256color'
[[ -n "$TMUX" ]] && export TERM='screen-256color'

export HISTTIMEFORMAT="%d/%m/%y %T "
export PS1="\[\e[0;33;49m\]\$(parse_git_branch)\[\e[0;31m\][\u@\h] \[\e[0;0m\]\w\n\[\e[0;33;49m\]→ \[\e[0;0m\]"

export SKIM_DEFAULT_COMMAND="rg --files || find ."

export GOPATH="$HOME/dev/go"
export WORKON_HOME="$HOME/dev/python"

PATH="$HOME/dotfiles/bin:$HOME/dev/go/bin:/usr/local/go/bin:$PATH"

if [[ -d "$HOME/.local/bin" ]]; then
  PATH="$HOME/.local/bin:$PATH"
fi
if [[ -d "$HOME/bin" ]]; then
  PATH="$HOME/bin:$PATH"
fi

if [[ -d "$HOME/.pyenv" ]]; then
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

[[ -s "${HOME}/.nvm/nvm.sh" ]] && . "${HOME}/.nvm/nvm.sh"


[[ -f "$HOME/dotfiles/bash_aliases" ]] && . $HOME/dotfiles/bash_aliases

[[ -f "$HOME/.bashrc-local" ]] && . "$HOME/.bashrc-local"
