#!/bin/bash

# Set environment variables
export ROS_LOCALHOST_ONLY=1
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
export CYCLONEDDS_URI=${CYCLONEDDS_URI:-'<CycloneDDS><Domain><General><Interfaces><NetworkInterface name="lo"/></Interfaces><AllowMulticast>true</AllowMulticast></General><Discovery><ParticipantIndex>none</ParticipantIndex></Discovery></Domain></CycloneDDS><Gen><Allow>spdp</Allow></Gen>'}

# Enable multicast on loopback interface
ip link set lo multicast on

# Adjust sysctl settings
sysctl -w net.core.rmem_max=2147483647

# Execute the command passed to the container
exec "$@"

