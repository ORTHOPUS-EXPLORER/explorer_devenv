#! /bin/bash

apt update
source /opt/ros/iron/setup.bash
rosdep install -i -y --from-paths .
