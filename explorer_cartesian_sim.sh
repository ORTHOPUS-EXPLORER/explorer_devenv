#! /bin/bash

. source.sh
./killall.sh
ros2 launch ros2_control_explorer cartesian_control.launch.py spacenav:=false
