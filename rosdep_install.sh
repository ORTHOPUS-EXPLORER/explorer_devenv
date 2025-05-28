#! /bin/bash

apt update
source /opt/ros/jazzy/setup.bash
rosdep install -i -y --from-paths .
