#! /bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

"$SCRIPT_DIR"/killall.sh
ros2 launch explorer_bringup explorer_cartesian.launch.py can_port:='can0' spacenav:=false simulation:=false
