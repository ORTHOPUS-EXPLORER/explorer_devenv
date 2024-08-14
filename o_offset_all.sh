#! /bin/bash

#ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_1','joint_2','joint_3','joint_4','joint_5','joint_6'], commands: ['o_offset encoder','o_offset encoder','o_offset encoder','o_offset encoder','o_offset encoder','o_offset encoder']}"

ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_1'], commands: ['o_offset encoder']}"

ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_2'], commands: ['o_offset encoder']}"

ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_3'], commands: ['o_offset encoder']}"

ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_4'], commands: ['o_offset encoder']}"

ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_5'], commands: ['o_offset encoder']}"

ros2 topic pub --once /explorer_cmd pyvesc_explorer_msgs/JointsCommands "{joint_names: ['joint_6'], commands: ['o_offset encoder']}"
