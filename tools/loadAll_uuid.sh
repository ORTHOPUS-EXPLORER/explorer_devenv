#!/bin/sh

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/build/"

cd "$VESCPP"
ls
./cli/vescpp_cli -i 11 -P can0 proxy fwinfo

can_port=""
dir=""
ids=""
if [ -z "$1" -o "$1" = "bench" ]; then
  echo "Config: Bench"
  can_port="can0"
  dir="bench"
  ids=`seq 11 16`
elif [ "$1" = "explorer" ]; then
  echo "Config: Explorer"
  can_port="can2"
  dir="explorer"
  ids=`seq 11 16`
else
  echo "Usage: $0 [explorer|bench]. Abort"
  exit 0
fi

#export SPDLOG_LEVEL=trace
cmd_base="./cli/vescpp_cli -f -P $can_port"

uuid_map_file="bench/uuid_map.txt"

for i in $ids; do
  uuid_line=$(grep "^$i " "$uuid_map_file")
  if [ -z "$uuid_line" ]; then
    echo "UUID not found for CAN ID $i, skipping..."
    continue
  fi
  uuid_from_file=$(echo "$uuid_line" | cut -d " " -f 2)
  for cnf in "motor" "custom" "app"; do
    cnff="`ls -Art $dir/${cnf}_conf_${i}_*.json 2> /dev/null | tail -n 1`"
    if [ -z "$cnff" ]; then
      continue
    fi
    cmd="$cmd_base -u $uuid_from_file load_conf $cnf $cnff"
    echo $cmd
    $cmd;
  done
done
