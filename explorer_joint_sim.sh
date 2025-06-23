#! /bin/bash

. source.sh
./killall.sh
ros2 launch ros2_control_explorer joint_control.launch.py
