#! /bin/bash

source install/setup.bash
spacenavd
ros2 launch ros2_control_explorer explorer_spacenav.launch.py gui:=true
