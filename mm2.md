In `/boot/config.txt` add `display_rotate=1`

In `/etc/lightdm/lightdm.conf` change `#xserver-command=X` to `xserver-command=X -s 0 -dpms`

In `/usr/share/dispsetup.sh` add `xrandr -o right`


## Running

Start from ssh: `DISPLAY=:0 nohup npm start &`



# MMPM
`sudo apt install libffi-dev nginx-full -y`
`python3 -m pip install --upgrade --no-cache-dir mmpm`
