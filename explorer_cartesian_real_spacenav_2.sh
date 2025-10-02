#! /bin/bash

spacenavd

. source.sh
./killall.sh
ros2 launch ros2_control_explorer explorer_cartesian.launch.py can_port:='can0'
