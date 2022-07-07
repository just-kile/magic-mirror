#!/bin/bash

docker rm magic_mirror

docker run\
 --publish 80:8080\
 --volume /home/pi/Documents/faces:/opt/data\
 --volume /opt/vc:/opt/vc\
 --volume /home/pi/Documents/config:/opt/magic_mirror/config\
 --name magic_mirror\
 --privileged\
 --env LD_LIBRARY_PATH=/opt/vc/lib\
 -it pboeck/magic_mirror