#! /bin/bash

. source.sh
ros2 launch ros2_control_actuator real_actuator.launch.py can_port:="can0" can_id:="11"
