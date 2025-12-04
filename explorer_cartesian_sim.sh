#! /bin/bash

. source.sh
./killall.sh
ros2 launch explorer_bringup cartesian_control.launch.py spacenav:=false
