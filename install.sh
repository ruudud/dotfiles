#/bin/bash

basedir=$(readlink -m `dirname $0`)

links=(
  profile xinitrc Xresources bashrc
  vim vimrc screenrc tmux.conf gitconfig
  i3status.conf i3 urxvt fonts
)
packages="curl rxvt-unicode-256color xclip vim git python-pip python-setuptools
  gnupg gnupg-agent pinentry-curses libssl-dev build-essential"

read -n1 -p "Symlink config files to $HOME (overwriting)? (y/n)" symlink_answer
echo ""
if [[ "$symlink_answer" == "y" ]]; then
  rm -rf "${HOME}/.i3"
  for fl in "${links[@]}"; do
    ln -sfn $basedir/$fl ${HOME}/.$fl
    echo -e "${HOME}/.$fl \t→\t $basedir/$fl"
  done

  # Rebuild fonts cache
  fc-cache -f
fi

read -n1 -p "Install urxvt, xclip, vim and other debs? (y/n)" debs_answer
echo ""
if [[ "$debs_answer" == "y" ]]; then
  sudo apt-get install "${packages}"
fi

read -n1 -p "Install rbenv and nvm? (y/n)" other_answer
echo ""
if [[ "$other_answer" == "y" ]]; then
  mkdir -p ~/.nvm
  curl -L https://github.com/creationix/nvm/archive/master.tar.gz \
    | tar -zx -C ${HOME}/.nvm --strip-components=1

  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
