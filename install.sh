#!/usr/bin/env bash

basedir="$(readlink -m "$(dirname "$0")")"

links=(
  fonts profile xinitrc Xresources bashrc XCompose
  vim vimrc screenrc tmux.conf gitconfig
  i3 config/termite config/dunst curlrc
  local/share/applications/mimeapps.list
)
packages="curl wget vim git openssh rsync\
  the_silver_searcher ripgrep bat exa\
  shotwell pcmanfm xorg-xprop xorg-xwd netpbm\
  xclip xorg-xinit xorg-xev xorg-xbacklight xautolock\
  alsa-utils pulseaudio pavucontrol pamixer\
  dunst termite ttf-inconsolata ttf-font-awesome\
  pass bash-completion tmux acpi acpid\
  sox imagemagick python-pip tmuxp\
  keybase gnupg ccid yubico-pam pcsc-tools libusb-compat pcsclite"

read -r -n1 -p "Symlink config files to $HOME (overwriting)? (y/n)" symlink_answer
echo ""
if [[ "$symlink_answer" == "y" ]]; then
  rm -rf "${HOME}/.i3"
  mkdir -p "${HOME}/.config"
  mkdir -p "${HOME}/.local/share/applications"
  for fl in "${links[@]}"; do
    ln -sfn "${basedir}/${fl}" "${HOME}/.${fl}"
    echo -e "${HOME}/.$fl \t→\t $basedir/$fl"
  done

fi

read -r -n1 -p "Install ${packages}? (y/n)" deps_answer
echo ""
if [[ "$deps_answer" == "y" ]]; then
  sudo pacman -Syu "${packages}"

  # Upgrade pip
  sudo pip install -U pip
fi

read -r -n1 -p "Install rbenv, nvm, virtualenv? (y/n)" other_answer
echo ""
if [[ "$other_answer" == "y" ]]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  pip install --user virtualenv
fi
