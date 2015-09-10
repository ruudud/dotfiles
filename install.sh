#/bin/bash

basedir=$(readlink -m `dirname $0`)

echo "Symlink config files to $HOME (will overwrite)? (y/n)"
read symlink_answer 

if [ "$symlink_answer" == "y" ]
then
    rm -rf "${HOME}/.i3"
    for fl in vim vimrc screenrc tmux.conf bashrc gitconfig i3status.conf i3 Xdefaults
    do
      ln -sfn $basedir/$fl ${HOME}/.$fl
      echo -e "${HOME}/.$fl \t→\t $basedir/$fl"
    done
fi

echo "Install urxvt, fonts, xclip, vim, rbenv and nvm? (y/n)"
read install_answer 

if [ "$install_answer" == "y" ]
then
    # Prevent nautilus from opening desktop
    gsettings set org.gnome.desktop.background show-desktop-icons false

    sudo apt-get install curl rxvt-unicode-256color fonts-inconsolata xclip vim git python-pip python-setuptools libssl-dev build-essential

    mkdir -p ~/.nvm
    curl -L https://github.com/creationix/nvm/archive/master.tar.gz | tar -zx -C ${HOME}/.nvm --strip-components=1

    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
