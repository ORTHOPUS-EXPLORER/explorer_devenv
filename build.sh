#! /bin/bash

apt update
source /opt/ros/iron/setup.bash
rosdep install -i -y --from-paths --ignore-src .
colcon build --symlink-install --continue-on-error
source install/setup.bash
