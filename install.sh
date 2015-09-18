#/bin/bash

basedir=$(readlink -m `dirname $0`)

links=(
  vim vimrc screenrc tmux.conf bashrc gitconfig
  i3status.conf i3 urxvt Xresources fonts
)
packages="curl rxvt-unicode-256color xclip vim git python-pip python-setuptools
  libssl-dev build-essential"

echo "Symlink config files to $HOME (will overwrite)? (y/n)"
read symlink_answer 

if [[ "$symlink_answer" == "y" ]]; then
  rm -rf "${HOME}/.i3"
  for fl in "${links[@]}"; do
    echo $fl
    ln -sfn $basedir/$fl ${HOME}/.$fl
    echo -e "${HOME}/.$fl \t→\t $basedir/$fl"
  done

  # Rebuild fonts cache
  fc-cache -f
fi

echo "Install urxvt, xclip, vim, rbenv and nvm? (y/n)"
read install_answer 

if [[ "$install_answer" == "y" ]]; then
  sudo apt-get install "${packages}"

  mkdir -p ~/.nvm
  curl -L https://github.com/creationix/nvm/archive/master.tar.gz \
    | tar -zx -C ${HOME}/.nvm --strip-components=1

  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
