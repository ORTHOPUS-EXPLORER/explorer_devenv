#! /bin/bash

docker build --cache-from ghcr.io/orthopus-explorer/ros-iron-explorer/dev:latest -t ros-iron-explorer  .
