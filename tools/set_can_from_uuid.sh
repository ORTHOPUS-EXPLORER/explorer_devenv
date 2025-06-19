#!/bin/sh

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/build/"

cd "$VESCPP"

can_port=""
ids=""
if [ -z "$1" -o "$1" = "bench" ]; then
  echo "Config: Bench"
  can_port="can0"
  ids=`seq 11 16`
  if [ $# -ge 1 ]; then
	shift;
  fi
elif [ "$1" = "explorer" ]; then
  echo "Config: Explorer"
  can_port="can2"
  ids=`seq 11 16`
  shift
else
  echo "Usage: $0 [explorer|bench] <cmd>. Abort"
  exit 0
fi

uuid_map_file="bench/uuid_map.txt"
#export SPDLOG_LEVEL=trace

while read -r can_id uuid; do
  echo "Setting CAN ID $can_id for UUID $uuid..."

  success=0
  while [ $success -eq 0 ]; do
    output=$(SPDLOG_LEVEL=trace ./cli/vescpp_cli -P "$can_port" -u "$uuid" proxy o_comm set_can_id "$can_id" 2>&1)
    echo "$output"
    echo "$output" | grep -qi "error"
    if [ $? -eq 0 ]; then
      echo "Retrying..."
      sleep 1
    else
      echo "Success for CAN ID $can_id"
      success=1
    fi
  done

done < "$uuid_map_file"
