# How to install?

Copy configs from this repo into `/etc/nixos/`, type `sudo nixos-build switch --flake .#{hostname}`

 
If touchpad right-click isn't working, try to paste this into the terminal
```bash
 gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
```
