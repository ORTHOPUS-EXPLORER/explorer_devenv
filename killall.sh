#!/bin/bash

if [ -z "$CATKIN_SHELL" ]; then
  CATKIN_SHELL=bash
fi
if [[ "$CATKIN_SHELL" == zsh ]]; then
    emulate -R zsh -c 'source `dirname $(cd "$(dirname "${(%):-%x}")" && pwd)/$(basename "${(%):-%x}")`/source.sh'
else
    source `dirname $(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")`/source.sh
fi

kill -9 `ps aux | grep "ros/${PROJECT_ROS_VERSION}\|${WORKSPACE_PATH}/install" | grep -v grep | awk '{ print $2; }' | xargs`

ros2 daemon stop
