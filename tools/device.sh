#! /bin/bash

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/"

cd "$VESCPP"build

./cli/vescpp_cli -i 127 -P can0 device

