# Magic Mirror

## Architecture

![Architecture Diagram](/doc/architecture.png)

## Run

* SSh to PI
* Start vnc server `vncserver`
* Switch to Python env `workon cv`

## Switch Display
### via ssh
```sh
xrandr -display :0 --output HDMI-1 --rotate left
```
### automatic
https://askubuntu.com/a/885247

```sh
# create /etc/xdg/autostart/setscreen.desktop
[Desktop Entry]
Name=Set Screen Rotation
Exec=/bin/bash -c "sleep 10 && xrandr --output HDMI-1 --rotate left"
Type=Application
```

```sh
chromium-browser http://localhost:3000 --auto-open-devtools-for-tabs
```

# Bullseye setup
* Enable legacy camera system via `sudo raspi-config` -> Interface
* Run `sudo apt update` and `sudo rpi-update` and reboot
* Then, `opt/vc/` should exist (see https://stackoverflow.com/a/70218011/912189)

# Buster Setup
`sudo raspi-config` 
    Interface Options -> activate camera
    Display Options -> disable underscan
    Display Options -> disable Screen blanking

# Docker 
## Install
```sh
sudo apt update
sudo apt upgrade

## Install Docker. Raspian doesn't support repository install
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

## Allow non-root
sudo usermod -aG docker $USER
newgrp docker 

## Testing
docker run hello-world
```

## Building

https://github.com/bastilimbach/docker-MagicMirror
https://forum.magicmirror.builders/topic/6345/facial-recognition-module-step-by-step-guide
https://github.com/nischi/MMM-Face-Reco-DNN
https://www.losant.com/blog/how-to-access-the-raspberry-pi-camera-in-docker

## Starting
```sh
export DISPLAY=:0 && chromium http://localhost -start-fullscreen
docker exec -it magic_mirror /bin/bash

# Test 
/opt/vc/bin/raspistill -o output.jpg
```