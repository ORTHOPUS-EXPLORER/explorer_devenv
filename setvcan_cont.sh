#! /bin/bash

ip link add dev vcan0 type vcan
ip link set mtu 16 up dev vcan0
