#!/usr/bin/env bash

basedir="$(readlink -m "$(dirname "$0")")"

links=(
  fonts profile xinitrc Xresources bashrc XCompose
  vim vimrc screenrc tmux.conf gitconfig
  i3 config/alacritty config/dunst config/fontconfig curlrc
  config/mimeapps.list
)

packages="dmenu i3-wm i3lock i3status xorg-server xorg-xinit\
  make patch docker\
  acpi acpid dunst feh pcmanfm\
  alsa-utils pulseaudio pavucontrol pamixer\
  xdotool xclip xorg-xset xorg-xinput xorg-xev xorg-xrandr xautolock xss-lock light\
  pass gnupg ccid yubico-pam pcsc-tools libusb-compat pcsclite\
  imagemagick shotwell xorg-xprop xorg-xwd netpbm\
  alacritty ttf-inconsolata tex-gyre-fonts noto-fonts-emoji\
  python-virtualenv python-pip\
  ripgrep skim bat exa\
  bash bash-completion curl wget vim git rsync jq\
  openssh tmux tmuxp"

aurpackages="otf-libertinus x11-emoji-picker"

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
  xargs sudo pacman -Suy <<<"$packages"

  sudo systemctl enable docker.service

  sudo gpasswd -a "$USER" docker
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

read -r -n1 -p "Install nvm and pyenv? (y/n)" progenvs_answer
echo ""
if [[ "$progenvs_answer" == "y" ]]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm

  sudo pacman -Suy pyenv
  eval "$(pyenv init -)"
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
  eval "$(pyenv virtualenv-init -)"
fi

read -r -n1 -p "Remap CapsLock to Ctrl, add current user to 'video' group to enable 'light' command, setup battery monitor and other ACPI events? (y/n)" desktop_answer
echo ""
if [[ "$desktop_answer" == "y" ]]; then

  sudo gpasswd -a "$USER" video
  sudo gpasswd -a "$USER" audio

  # NOTE: the following ACPI bindings are only necessary when the
  # 'XF86MonBrightnessUp' keyboard event isn't triggered
  sudo tee "/etc/acpi/events/brightnessdown" <<'EOF'
event=video/brightnessdown.*
action=/usr/bin/light -U 10
EOF

  sudo tee "/etc/acpi/events/brightnessup" <<'EOF'
event=video/brightnessup.*
action=/usr/bin/light -A 10
EOF

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
