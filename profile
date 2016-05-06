# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


PATH="$HOME/.rbenv/bin:$HOME/dotfiles/bin:$HOME/dev/go/bin:/usr/local/go/bin:$PATH"

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
	  . "$HOME/.bashrc"
  fi
fi

[[ -s /usr/bin/virtualenvwrapper.sh ]] && . /usr/bin/virtualenvwrapper.sh
[[ -s "${HOME}/.nvm/nvm.sh" ]] && . "${HOME}/.nvm/nvm.sh"
eval "$(rbenv init -)"

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

