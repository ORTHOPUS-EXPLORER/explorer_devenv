#! /bin/bash

apt update
#apt install -y libnlopt0
source /opt/ros/jazzy/setup.bash
rosdep install -i -y --from-paths .
source /opt/ros/jazzy/setup.bash
#rosdep install -i -y --from-paths .
colcon build --symlink-install --continue-on-error
source install/setup.bash
#ros2 launch ros2_control_explorer explorer_spacenav.launch.py gui:=true
