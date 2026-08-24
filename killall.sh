#!/bin/bash

kill -9 `ps aux | grep "ros/${PROJECT_ROS_VERSION}\|${WORKSPACE_PATH}/install" | grep -v grep | awk '{ print $2; }' | xargs`

ros2 daemon stop
