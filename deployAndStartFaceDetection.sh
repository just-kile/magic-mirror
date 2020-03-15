#!/usr/bin/env bash
scp face-detection/face_detecter.py pi@magic-mirror-paul:./face_detection/
ssh pi@magic-mirror-paul 'cd face_detection && workon cv && python face_detecter.py'