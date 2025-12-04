#! /bin/bash

. source.sh
./killall.sh
ros2 launch explorer_bringup cartesian_control.launch.py can_port:='can0' simulation:=false
