#!/bin/sh

VESCPP="../src/explorer_ws/explorer_stack/libs/orthopus_vesc/lib/vescpp/build/"
rm -rf "$VESCPP"bench/
mkdir -p "$VESCPP"bench/
mkdir -p "$VESCPP"bench/log



script -q -c "./proxyAll.sh bench fwinfo" /dev/stdout | tee "$VESCPP"bench/log/fwinfo_before.log
sleep 5
script -q -c "./saveAll_uuid.sh" /dev/stdout | tee "$VESCPP"bench/log/saveAll_uuid.log
sleep 5
script -q -c "./proxyAll.sh bench o_comm stream_rate 0" /dev/stdout | tee "$VESCPP"bench/log/stream_rate.log
sleep 5
script -q -c "./flash_all.sh" /dev/stdout | tee "$VESCPP"bench/log/flash_all.log
echo "wait 60s, waiting  for VESCs to come back"
sleep 60
script -q -c "./loadAll_uuid.sh" /dev/stdout | tee "$VESCPP"bench/log/loadAll_uuid.log
sleep 1
script -q -c "./loadAll_uuid.sh" /dev/stdout | tee "$VESCPP"bench/log/loadAll_uuid-2.log
sleep 1
script -q -c "./loadAll_uuid.sh" /dev/stdout | tee "$VESCPP"bench/log/loadAll_uuid-3.log
sleep 1
script -q -c "./proxyAll.sh bench o_config save" /dev/stdout | tee "$VESCPP"bench/log/config_save.log
script -q -c "./proxyAll.sh bench fwinfo" /dev/stdout | tee "$VESCPP"bench/log/fwinfo_before.log
sleep 5
