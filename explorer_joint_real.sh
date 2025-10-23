#! /bin/bash

. source.sh
./killall.sh
ros2 launch explorer_bringup explorer_joint.launch.py can_port:='can0'
