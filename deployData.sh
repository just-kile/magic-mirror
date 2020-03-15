#!/usr/bin/env bash
tar -zcvf target/data.tar.gz ./data/
scp target/data.tar.gz pi@magic-mirror-paul:./face_detection/
ssh pi@magic-mirror-paul 'cd face_detection && tar -zxvf data.tar.gz'