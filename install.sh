#/bin/bash

basedir=$(readlink -m `dirname $0`)

links=(
  fonts profile xinitrc Xresources bashrc
  vim vimrc screenrc tmux.conf gitconfig
  i3status.conf i3 config/termite
)
packages="curl wget the_silver_searcher vim git openssh rsync\
  shotwell pcmanfm xorg-xprop xorg-xwd netpbm\
  xclip xorg-xinit xorg-xev xorg-xbacklight\
  alsa-utils pulseaudio pavucontrol pamixer\
  termite ttf-inconsolata\
  pass bash-completion tmux acpid\
  python-pip python-virtualenvwrapper\
  keybase gnupg ccid yubico-pam pcsc-tools libusb-compat pcsclite"

pythonpackages="tmuxp"

read -n1 -p "Symlink config files to $HOME (overwriting)? (y/n)" symlink_answer
echo ""
if [[ "$symlink_answer" == "y" ]]; then
  rm -rf "${HOME}/.i3"
  for fl in "${links[@]}"; do
    ln -sfn $basedir/$fl ${HOME}/.$fl
    echo -e "${HOME}/.$fl \t→\t $basedir/$fl"
  done

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
  git clone https://github.com/creationix/nvm.git ~/.nvm
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
