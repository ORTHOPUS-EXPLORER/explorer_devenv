#! /bin/bash

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/"

cd "$VESCPP"build

./cli/vescpp_cli -P can0 -i 14 flash_fw app /home/thomas/Documents/vesc_devenv_github/vesc_devenv/vesc_firmware/build/a50s_v23c_8s/a50s_v23c_8s.bin

