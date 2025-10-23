#! /bin/bash

spacenavd

. source.sh
./killall.sh
ros2 launch explorer_bringup explorer_cartesian.launch.py can_port:='can0'
