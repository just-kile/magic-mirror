
## Steps

* Install Python and OpenCV 4 on PI 4 https://www.pyimagesearch.com/2019/09/16/install-opencv-4-on-raspberry-pi-4-and-raspbian-buster/

```sh
sudo apt install build-essential cmake pkg-config libjpeg-dev libtiff5-dev libjasper-dev libpng-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran libatlas-base-dev gfortran libhdf5-dev libhdf5-serial-dev libhdf5-103 libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5 python3-dev
```

```sh
sudo pip install virtualenv virtualenvwrapper
```

Append to `~/.bashrc`

```
# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
source /usr/local/bin/virtualenvwrapper.sh
```

```
mkvirtualenv cv -p python3
```

Fix python env with https://stackoverflow.com/questions/60252119/error-environment-users-myuser-virtualenvs-iron-does-not-contain-activation-s/60292344#60292344


pip install "picamera[array]"
pip install opencv-contrib-python==4.1.0.25
pip install numpy
pip install dlib

https://github.com/ageitgey/face_recognition

pip install face_recognition
pip install -U scikit-learn

## Notes
Face detection seems to be very robust against facial expressions but very fragile on unbalanced data.

## References

https://www.instructables.com/id/Who-Is-at-the-Coffee-Machine-Facial-Recognition-Us/