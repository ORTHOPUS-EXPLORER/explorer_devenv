#!/bin/bash
sudo ip link set can0 up type can bitrate 500000
sudo ip link set can0 txqueuelen 100
