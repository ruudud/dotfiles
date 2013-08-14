#/bin/bash

basedir=$(readlink -m `dirname $0`)

echo "Symlink config files to $HOME (will overwrite)? (y/n)"
read symlink_answer 

if [ "$symlink_answer" == "y" ]
then
    for fl in vim vimrc screenrc tmux.conf bashrc gitconfig i3status.conf "i3/"
    do
      ln -sfn $basedir/$fl ${HOME}/.$fl
      echo -e "${HOME}/.$fl \t→\t $basedir/$fl"
    done

    venv_dir="${HOME}/dev/.virtualenvs"
    mkdir -p $venv_dir
    ln -sfn $basedir/virtualenvwrapper/postactivate $venv_dir/postactivate
fi

echo "Install solarized color scheme? (y/n)"
read color_answer

if [ "$color_answer" == "y" ]
then
    /bin/bash $basedir/solarized/install.sh
fi

echo "Install fonts, xclip, vim, virtualenv and nvm? (y/n)"
read install_answer 

if [ "$install_answer" == "y" ]
then
    sudo apt-get install curl ttf-inconsolata xclip vim python-pip python-setuptools libssl-dev build-essential
    sudo pip install --upgrade pip
    sudo pip install virtualenv virtualenvwrapper

    mkdir -p ~/.nvm
    curl -L https://github.com/creationix/nvm/archive/master.tar.gz | tar -zx -C ${HOME}/.nvm --strip-components=1
fi
