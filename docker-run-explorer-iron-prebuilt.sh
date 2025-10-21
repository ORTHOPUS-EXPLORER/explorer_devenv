#! /bin/bash

xhost +
docker run --rm -d --name ros-iron-explorer --network host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --privileged -v "/dev/:/dev" -v `pwd`:/src -ti ros-iron-explorer:prebuilt terminator
