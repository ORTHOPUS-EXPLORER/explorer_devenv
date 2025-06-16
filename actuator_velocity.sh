#! /bin/bash

. source.sh
ros2 launch ros2_control_actuator real_actuator_velocity.launch.py can_port:="can0" can_id:="11"
