#/bin/bash

basedir=$(readlink -m `dirname $0`)

links=(
  profile xinitrc Xresources bashrc
  vim vimrc screenrc tmux.conf gitconfig
  i3status.conf i3 urxvt fonts
)
packages="curl wget the_silver_searcher vim git openssh xclip\
  shotwell pcmanfm xorg-xprop xorg-xwd netpbm\
  rxvt-unicode urxvt-perls pass bash-completion\
  tmux\
  python-pip python-virtualenvwrapper\
  gnupg ccid yubico-pam pcsc-tools libusb-compat pcsclite"

pythonpackages="tmuxp"

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

  # Create Virtualenvwrapper folder
  mkdir -p "${HOME}/dev/python"
fi

read -n1 -p "Install ${packages[@]}? (y/n)" debs_answer
echo ""
if [[ "$debs_answer" == "y" ]]; then
  sudo pacman -Syu "${packages}"

  # Upgrade pip
  sudo pip install -U pip
  pip install --user "${pythonpackages}"
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
