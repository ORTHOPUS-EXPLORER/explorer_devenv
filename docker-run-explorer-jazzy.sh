#! /bin/bash

xhost +
docker run --rm -it --name ros-jazzy-explorer -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --privileged -v "/dev/:/dev" -v `pwd`:/src -ti ros-jazzy-explorer bash 
