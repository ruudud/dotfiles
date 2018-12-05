# dotfiles

## install
Run `install.sh` if you are lazy like me.

## remap keyboard

To re-map notsign ⌐ to asciitilde with the 'gb' xkb layout, modify
/usr/share/X11/xkb/gb to

key <TLDE>  { [     grave,    asciitilde,          bar,          bar ]      };

## setup battery check
In `~/.config/systemd/user/battery-check.service`:

```
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
```

Then, `systemctl --user enable battery-check.service`
