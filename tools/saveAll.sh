#!/bin/sh

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/build/"

cd "$VESCPP"

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

mkdir -p bench
ls

cmd_base="./cli/vescpp_cli -P $can_port -D $dir"

for i in $ids; do 
  for cnf in "app" "motor" "custom"; do
    cmd="$cmd_base -i $i save_conf $cnf"
    #echo $cmd
    $cmd;
  done
done
