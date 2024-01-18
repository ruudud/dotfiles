# dotfiles
I use [Arch Linux](https://archlinux.org/), and although the dotfiles probably
work in most "standard" setups, both the install and the configuration is
colored by this.


## install
Run `install.sh` if you are lazy like me, to link files and install
dependencies.


## Other things

  * fonts: https://aswinmohan.me//better-fonts-on-linux/
  * yubikey: https://github.com/drduh/YubiKey-Guide

### /etc/systemd/

  * `logind.conf`: `HandleLidSwitch=suspend-then-hibernate`
  * `sleep.conf`: `HibernateDelaySec=600`


### Yubikey

```
gpg --import mykey.pub
gpg --edit-key <KEYID>
trust
5
y
quit
gpg --card-status
```
