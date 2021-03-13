#!/usr/bin/env bash

basedir="$(readlink -m "$(dirname "$0")")"

links=(
  fonts profile xinitrc Xresources bashrc XCompose
  vim vimrc screenrc tmux.conf gitconfig
  i3 config/termite config/dunst config/fontconfig curlrc
  local/share/applications/mimeapps.list
)

desktoppackages="dmenu i3-wm xorg-server xorg-xinit\
  acpi acpid xf86-video-intel dunst feh pcmanfm\
  alsa-utils pulseaudio pavucontrol pamixer\
  xdotool xclip xorg-xev xorg-xrandr xorg-xbacklight xautolock\
  pass gnupg ccid yubico-pam pcsc-tools libusb-compat pcsclite\
  imagemagick shotwell xorg-xprop xorg-xwd netpbm\
  termite ttf-inconsolata tex-gyre-fonts noto-fonts-emoji"

packages="ripgrep skim bat exa\
  bash bash-completion curl wget vim git rsync\
  openssh tmux tmuxp"

aurpackages="otf-libertinus"

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

read -r -n1 -p "Install ${desktoppackages}? (y/n)" deskdeps_answer
echo ""
if [[ "$deskdeps_answer" == "y" ]]; then
  sudo pacman -Syu "$desktoppackages"
fi

read -r -n1 -p "Install ${packages}? (y/n)" deps_answer
echo ""
if [[ "$deps_answer" == "y" ]]; then
  sudo pacman -Syu "$packages"
fi

read -r -n1 -p "Install yay and aur packages ${aurpackages})? (y/n)" aur_answer
echo ""
if [[ "$aur_answer" == "y" ]]; then
  mkdir -p "${HOME}/tmp" && cd $_
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si

  yay -S "$aurpackages"
fi

read -r -n1 -p "Install nvm and pyenv? (y/n)" other_answer
echo ""
if [[ "$other_answer" == "y" ]]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm

  sudo pacman -Suy pyenv
  eval "$(pyenv init -)"
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
  eval "$(pyenv virtualenv-init -)"
fi

read -r -n1 -p "Remap CapsLock to Ctrl, and setup battery monitor? (y/n)" desktop_other_answer
echo ""
if [[ "$desktop_other_answer" == "y" ]]; then

  sudo tee "/etc/X11/xorg.conf.d/00-keyboard.conf" <<'EOF'
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
        Option "XkbOptions" "compose:ralt,ctrl:nocaps"
EndSection
EOF


  mkdir -p "${HOME}/.config/systemd/user"

  tee "${HOME}/.config/systemd/user/battery-check.service" <<'EOF'
[Unit]
Description=Battery Monitor

[Service]
Type=simple
Environment=DISPLAY=:0
Environment=XAUTHORITY=%h/.Xauthority
ExecStart=/bin/bash %h/dotfiles/bin/check-battery
Restart=always
RestartSec=10

[Install]
WantedBy=default.target
EOF

  systemctl --user enable battery-check.service

  echo "Changes to keyboard takes effect when X is restarted."
fi
