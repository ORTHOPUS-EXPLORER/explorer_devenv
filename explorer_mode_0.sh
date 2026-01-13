#! /bin/bash

. source.sh
./killall.sh
ros2 launch explorer_user_interfaces_cpp mode_0.launch.py simulation:=false gui:=false
