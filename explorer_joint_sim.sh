#! /bin/bash

. source.sh
./killall.sh
ros2 launch explorer_bringup joint_control.launch.py
